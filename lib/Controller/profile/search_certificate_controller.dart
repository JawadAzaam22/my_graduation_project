import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/base_url.dart';
import '../../Services/service.dart';
import '../../l10n/app_localizations.dart';

class SearchCertificateController extends GetxController {
  late final UserService service;

  final RxBool _isLoading2 = false.obs;
  RxBool get isLoading2 => _isLoading2;

  final RxString certificateUrl = ''.obs;

  @override
  void onInit() {
    service = Get.find<UserService>();
    super.onInit();
  }

  late BuildContext context;
  final TextEditingController searchCerController = TextEditingController();
  final RxBool hasSearched = false.obs;

  final RxString certificateDate = ''.obs;
  Future<void> searchCertificate(String code) async {
    hasSearched.value = true;
    dio.Dio d = dio.Dio();
    try {
      _isLoading2.value = true;
      dio.Response r = await d.post(
        "$baseURL/api/v1/certificate/by-code",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
        data: {
          "code": code,
        },
      );
      _isLoading2.value = false;

      if (r.statusCode == 200 && r.data["status"] == "success") {
        final url = r.data["data"]["certification_image"] ?? '';
        final date = r.data["data"]["certification_attached_at"] ?? '';
        certificateUrl.value = url;
        certificateDate.value = date;
        if (url.isEmpty) {
          Get.snackbar("alert", 'No Certificate for this code');
        }
      } else {
        certificateUrl.value = '';
        certificateDate.value = '';
        Get.snackbar("alert", 'No Certificate for this code');
      }
    } on dio.DioException catch (e) {
      _isLoading2.value = false;
      certificateUrl.value = '';
      certificateDate.value = '';
      Get.snackbar("خطأ", e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> saveToGallery() async {
    final url = certificateUrl.value;
    if (url.isEmpty) {
      Get.snackbar(AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.noCerToSave);
      return;
    }
    try {
      final result = await GallerySaver.saveImage(url,
          albumName: "German Board Certificates");
      if (result == true) {
        Get.snackbar(AppLocalizations.of(context)!.success,
            AppLocalizations.of(context)!.cerSaved);
      }
    } catch (e) {
      Get.snackbar(AppLocalizations.of(context)!.error, '$e');
    }
  }

  Future<void> shareAssetImage(String imageUrl) async {
    if (imageUrl.isEmpty) {
      Get.snackbar('error', 'no certificate available');
      return;
    }
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName =
          'certificate_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';

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
    } catch (e) {
      Get.snackbar('error', '$e');
    }
  }

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
          "training_id": 3,
          "value": value,
        },
      );
      _isLoading2.value = false;

      if (r.data["status"] == "success") {
      } else {
        Get.snackbar('alert', 'no cer for this code');
      }
    } on dio.DioException catch (e) {
      _isLoading2.value = false;

      Get.snackbar("خطأ", e.response?.data["message"] ?? e.message);
    }
  }

  Future<bool> hasRatedCourse(int userId, int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rated_${userId}_$courseId') ?? false;
  }

  Future<void> setRatedCourse(int userId, int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rated_${userId}_$courseId', true);
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
      image: const Icon(Icons.star, size: 60, color: Colors.amber),
      submitButtonText: AppLocalizations.of(context)!.rate,
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
}
