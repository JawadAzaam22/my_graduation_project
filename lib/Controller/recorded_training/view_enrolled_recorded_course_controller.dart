import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../Constants/base_url.dart';
import '../../Models/recorded/lesson.dart';
import '../../Services/service.dart';

import 'package:dio/dio.dart' as dio;

import '../../View/widgets/Recorded training/lessons_widget.dart';
import '../../l10n/app_localizations.dart';


class ViewEnrolledRecordedCourseController extends GetxController with GetSingleTickerProviderStateMixin {
  @override
  void onInit()async {
    id=Get.arguments["id"];
    tabController = TabController(
        length: 3,
        vsync: this
    );
    await _loadDownloadMetadata();
    _verifyExistingFiles();
   //
    service = Get.find<UserService>();
    await getVideosAndExams ();
    checkAllVideosWatched(context);
    super.onInit();

  }
  late BuildContext context;
  late int id;
  final RxBool isLoadingVid = RxBool(false);
  late final UserService service;
  late TabController tabController;
  @override
  void onClose() {
    _saveDownloadMetadata();
    tabController.dispose();
    super.onClose();
  }


  final RxBool isLoading = false.obs;





  void showNoteDialog(String? noteContent) {
    Get.dialog(
      AlertDialog(

        content: Text(noteContent ?? '........'),

      ),
    );
  }



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








  final dio.Dio _dio = dio.Dio();
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
  String _sanitizeFileName(String url) {
    return Uri.parse(url).pathSegments.last
        .replaceAll(RegExp(r'[^\w.-]'), '_')
        .replaceAll(' ', '_');
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



  // Future<void> openFile(String url) async {
  //   if (!isFileDownloaded(url)) {
  //     Get.snackbar('تنبيه', 'الرجاء تنزيل الملف أولاً');
  //     return;
  //   }
  //
  //   final result = await OpenFilex.open(_downloadedFiles[url]!);
  //   if (result.type != ResultType.done) {
  //     Get.snackbar('خطأ', 'لا يوجد تطبيق مناسب لفتح الملف');
  //   }
  // }
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




  ///////certificate

  String patt="https://hips.hearstapps.com/hmg-prod/images/gettyimages-996289560-651aee78b67aa.jpg?crop=0.536xw:1.00xh;0.318xw,0&resize=980:*";
  Future<void> saveToGallery1() async{
    await GallerySaver.saveImage(patt);

  }
  // Future<void> shareNetworkImageWithDio(String imageUrl) async {
  //   try {
  //     // 1. تهيئة Dio
  //     final dio = Dio();
  //
  //     // 2. الحصول على مسار مؤقت لحفظ الصورة
  //     final tempDir = await getTemporaryDirectory();
  //     final fileName = 'shared_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //     final filePath = '${tempDir.path}/$fileName';
  //
  //     // 3. تحميل الصورة وحفظها باستخدام Dio
  //     await dio.download(
  //       imageUrl,
  //       filePath,
  //       options: Options(responseType: ResponseType.bytes),
  //     );
  //
  //     // 4. مشاركة الصورة كملف
  //     await Share.shareXFiles(
  //       [XFile(filePath, mimeType: 'image/jpeg')],
  //       subject: 'مشاركة الصورة',
  //       text: 'تمت مشاركة هذه الصورة من تطبيق ${Get.appTitle}',
  //     );
  //
  //     // 5. (اختياري) حذف الملف بعد المشاركة
  //     // await File(filePath).delete();
  //   } on DioException catch (e) {
  //     Get.snackbar('خطأ', 'فشل تحميل الصورة: ${e.message}');
  //   } catch (e) {
  //     Get.snackbar('خطأ', 'حدث خطأ غير متوقع: $e');
  //   }
  // }
  Future<void> shareAssetImage1
      (String assetPath) async {
    try {

      final byteData = await rootBundle.load('assets/$assetPath');
      final bytes = byteData.buffer.asUint8List();


      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.jpg');
      await file.writeAsBytes(bytes);


      await Share.shareXFiles([XFile(file.path)]);
    } catch (e) {
      print('$e');
    }
  }

////////////////////////////////////////////////////


  Future<void> saveToGallery() async {
    final url = lesson.value?.certificationImage;
    if (url!.isEmpty) {
      Get.snackbar( AppLocalizations.of(context)!.error, AppLocalizations.of(context)!.noCerToSave);
      return;
    }
    try {
      final result = await GallerySaver.saveImage(url, albumName: "German Board Certificates");
      if (result == true) {
        Get.snackbar( AppLocalizations.of(context)!.success,  AppLocalizations.of(context)!.cerSaved);
      }
    } catch (e) {
      Get.snackbar( AppLocalizations.of(context)!.error,'$e');
    }
  }


  Future<void> shareAssetImage(String imageUrl) async {
    if (imageUrl.isEmpty) {
      Get.snackbar('خطأ', 'لا يوجد شهادة متاحة للمشاركة');
      return;
    }
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = 'certificate_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';

      // تحميل الصورة من الإنترنت
      await Dio().download(
        imageUrl,
        filePath,
        options: Options(responseType: ResponseType.bytes),
      );

      await Share.shareXFiles(
        [XFile(filePath, mimeType: 'image/jpeg')],
        subject: 'شهادة دورة',
        text: 'تم الحصول على هذه الشهادة من تطبيق German Board!',
      );

      // يمكنك حذف الملف المؤقت بعد المشاركة إذا أردت
      // await File(filePath).delete();
    } catch (e) {
      Get.snackbar('خطأ', 'تعذر مشاركة الشهادة: $e');
    }
  }



  ////////////////////////////////
  void navToQuiz(int quizID){
    Get.toNamed("/quiz",arguments:{
      "quizID" :quizID,
    })?.then((result) async {
      if (result == true) {
        await getVideosAndExams ();

      }
    });
  }

  final Rx<Lesson?> lesson = Rx<Lesson?>(null);

  Future<void> getVideosAndExams() async {
    dio.Dio d = dio.Dio();

    try {
      isLoadingVid.value = true;
      dio.Response r = await d.get("$baseURL/api/v1/trainee/training/getVideosAndExams/$id",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },),
      );
      if (r.statusCode == 200 && r.data["status"] == "success") {
        final lessonData = r.data["data"];
        lesson.value = Lesson.fromJson(lessonData);




      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
      isLoadingVid.value = false;
    } on dio.DioException catch (e) {
      isLoadingVid.value = false;
      print("eeeeeeeeeeeeeeeee");
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }

  }

  Future<void> changeVideoStatus(int vidId,BuildContext context) async {
    dio.Dio d = dio.Dio();

    try {
      isLoadingVid.value = true;
      dio.Response r = await d.post(
        "$baseURL/api/v1/trainee/training/video/watched/$vidId",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
      );
      if (r.statusCode == 200 && r.data["status"] == "success") {

        final lesson = this.lesson.value;
        if (lesson != null) {
          final index = lesson.items.indexWhere((item) => item.videoId == vidId);
          if (index != -1) {
            lesson.items[index].status = true;

            this.lesson.refresh();

          }
        }
        checkAllVideosWatched(context);
        Get.back();
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
      isLoadingVid.value = false;
    } on dio.DioException catch (e) {
      isLoadingVid.value = false;
      print("eeeeeeeeeeeeeeeee");
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }



  void checkAllVideosWatched(BuildContext context) {
    if (lesson.value == null) return;


    final videoItems = lesson.value!.items.where((item) => item.type == "video");


    final allWatched = videoItems.every((video) => video.status == true);

    if (allWatched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkAndShowRatingDialog(
          context,
          service.currentUser!.id??1,
          3,
              (rating) async {
            await rateCourse(rating);
          },
        );
      });
    } else {
      print("لم يتم مشاهدة كل الفيديوهات");
    }
  }
  final RxBool _isLoading2 = false.obs;
  RxBool get isLoading2 => _isLoading2;
  Future<void> rateCourse(double value) async {

    dio.Dio d = dio.Dio();
    try {
      _isLoading2.value = true;
      dio.Response r = await d.post(
        "$baseURL/api/v1/trainee/rating",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
        data: {
          "training_id" : 3,
          "value" : value,
        },
      );
      _isLoading2.value = false;

      if ( r.data["status"] == "success") {
        print("ratttttttting ");

      } else {

        Get.snackbar('تنبيه', 'لا توجد شهادة لهذا الكود');
      }
    } on dio.DioException catch (e) {
      _isLoading2.value = false;

      Get.snackbar("خطأ", e.response?.data["message"] ?? e.message);
    }
  }
  void checkAndShowRatingDialog(
      BuildContext context,
      int userId,
      int courseId,
      Future<void> Function(double) onSubmit,
      ) async {
    if (!await hasRatedCourse(userId, courseId)) {
      showCourseRatingDialog(context, userId, courseId, onSubmit);
    }
  }
  void showCourseRatingDialog(
      BuildContext context,
      int userId,
      int courseId,
      Future<void> Function(double) onSubmit,
      ) {
    final _dialog = RatingDialog(
      initialRating: 3.0,
      title: Text(
        AppLocalizations.of(context)!.rateCourse,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      message: Text(
        AppLocalizations.of(context)!.selectRating,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
      image: Icon(Icons.star, size: 60, color: Colors.amber),
      submitButtonText:  AppLocalizations.of(context)!.rate,
      enableComment: false,
      onCancelled: () => print('تم الإلغاء'),
      onSubmitted: (response) async {
        await onSubmit(response.rating);
        await setRatedCourse(userId, courseId);
      },
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _dialog,
    );
  }

  Future<bool> hasRatedCourse(int userId, int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rated_${userId}_$courseId') ?? false;
  }

  Future<void> setRatedCourse(int userId, int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rated_${userId}_$courseId', true);
  }




}
