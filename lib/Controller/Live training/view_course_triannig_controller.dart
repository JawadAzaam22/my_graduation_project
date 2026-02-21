import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../../Constants/base_url.dart';
import '../../Models/live_training/enrolled_live_training_details_model.dart';
import '../../Services/service.dart';

class ViewCourseTriannigController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  Future<void> onInit() async {
    service = Get.find<UserService>();
    id = Get.arguments["id"];

    tabController = TabController(length: 3, vsync: this);
    await getCourseDetails();
    await _loadDownloadMetadata();
    _verifyExistingFiles();
    super.onInit();
  }

  late int id;
  late TabController tabController;
  @override
  void onClose() {
    _saveDownloadMetadata();
    tabController.dispose();
    super.onClose();
  }


  final List<String> statusList = [
    'completed',
    'ongoing',
    'not_started',
    'canceled',
  ];

  final RxBool isLoading = false.obs;

  Color getStatusColor(String? status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'ongoing':
        return Colors.blue;
      case 'canceled':
        return Colors.red;
      case 'not_started':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void showNoteDialog(String? noteContent) {
    Get.dialog(
      AlertDialog(
        content: Text(noteContent ?? '........'),
      ),
    );
  }

  final RxBool _isLoadingDetails = RxBool(false);
  late final UserService service;
  bool get isLoadingDetails => _isLoadingDetails.value;

  final RxList<Sessions> sessions = RxList([]);
  final RxList<Attachments> attachments = RxList([]);
  final Rx<EnrolledLiveTraining?> training = Rx<EnrolledLiveTraining?>(null);

  Future<void> getCourseDetails() async {
    dio.Dio d = dio.Dio();

    try {
      _isLoadingDetails.value = true;
      dio.Response r =
          await d.post("$baseURL/api/v1/training/getTrainingDetails",
              options: dio.Options(
                headers: {
                  "Authorization": "Bearer ${service.token}",
                },
              ),
              data: {
            "training_id": id,
          });
      if (r.statusCode == 200 && r.data["status"] == "success") {
        training.value = EnrolledLiveTraining.fromJson(r.data["data"]);
        print("ssss");
        if (training.value != null) {
          sessions.assignAll(training.value!.sessions ?? []);
          attachments.assignAll(training.value!.attachments ?? []);
        }

        print("aaaa");
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
    } on dio.DioException catch (e) {
      print("eeeeeeeeeeeeeeeee");
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    } finally {
      _isLoadingDetails.value = false;
    }
  }

  final dio.Dio _dio = dio.Dio();

  final RxMap<String, String> _downloadedFiles = <String, String>{}.obs;
  Future<void> _initDownloadedFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync();

    for (var file in files) {
      if (file is File) {
        final url = _generateUrlFromFileName(file.path);
        _downloadedFiles[url] = file.path;
      }
    }
    update();
  }

  String _generateUrlFromFileName(String path) {
    final fileName = path.split('/').last;
    return 'https://backend.germanboard.org/storage/$fileName';
  }

  bool isFileDownloaded(String url) {
    return _downloadedFiles.containsKey(url) &&
        File(_downloadedFiles[url]!).existsSync();
  }

  Future<File> get _metadataFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/downloads_metadata.json');
  }

  Future<void> _saveDownloadMetadata() async {
    final file = await _metadataFile;
    await file.writeAsString(json.encode(_downloadedFiles));
  }

  Future<void> _loadDownloadMetadata() async {
    try {
      final file = await _metadataFile;
      if (await file.exists()) {
        final data = json.decode(await file.readAsString());
        _downloadedFiles.value = Map<String, String>.from(data);
      }
    } catch (e) {
      print('Error loading metadata: $e');
    }
  }

  Future<void> downloadFile(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = _generateUniqueFileName(url);
      final savePath = '${dir.path}/$fileName';

      await _dio.download(
        url,
        savePath,
        options: Options(headers: {'Authorization': 'Bearer ${service.token}'}),
      );

      _downloadedFiles[url] = savePath;
      await _saveDownloadMetadata();
      update();
    } catch (e) {
      Get.snackbar('Error', 'Download failed: ${e.toString()}');
    }
  }

  String _generateUniqueFileName(String url) {
    final uri = Uri.parse(url);
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${timestamp}_${uri.pathSegments.last}';
  }

  Future<void> _verifyExistingFiles() async {
    final keysToRemove = <String>[];

    for (final entry in _downloadedFiles.entries) {
      if (!await File(entry.value).exists()) {
        keysToRemove.add(entry.key);
      }
    }

    keysToRemove.forEach(_downloadedFiles.remove);
    await _saveDownloadMetadata();
    update();
  }

  Future<void> openFile(String url) async {
    try {
      if (!_downloadedFiles.containsKey(url)) {
        throw Exception('File not downloaded');
      }

      final result = await OpenFilex.open(_downloadedFiles[url]!);

      if (result.type != ResultType.done) {
        Get.snackbar('خطأ', 'تعذر فتح الملف');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ: ${e.toString()}');
      _downloadedFiles.remove(url);
      await _saveDownloadMetadata();
    }
  }

  void navToVid() {
    Get.toNamed("/agora", arguments: {
      "id": id,
    });
  }
  Future<void>handleRefresh()async
  {
    await getCourseDetails();
  }
}
