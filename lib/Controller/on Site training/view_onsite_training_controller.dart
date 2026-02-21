import 'package:german_board/Constants/base_url.dart';
import 'package:get/get.dart';
import '../../Models/live_training/Live_training.dart';
import '../../Services/service.dart';
import 'package:dio/dio.dart' as dio;

class ViewOnsiteTrainingController extends GetxController {
  late final UserService service;
  final RxBool isShortText = false.obs;
  final RxBool isExpanded = false.obs;
  final RxBool isLoading = true.obs;
  final RxBool isFailed = false.obs;

  void toggleDescription() => isExpanded.toggle();
  final onSiteTraining = Rxn<LiveTraining>();
  final dio.Dio _dio = dio.Dio();

  @override
  void onInit() async {
    super.onInit();
    service = Get.find<UserService>();
    id = Get.arguments["id"];
    await getCourseDetails();
  }

  void navToViewProfile(int id) {
    Get.toNamed("/userprofiles", arguments: {
      "id": id,
    });
  }

  late int id;

  String getLanguage(String? language) {
    switch (language) {
      case "en":
        return "English";
      case "ar":
        return "Arabic";
      case "de":
        return "Deutsch";
      default:
        return "";
    }
  }

  Future<void> getCourseDetails() async {
    isLoading.value = true;
    isFailed.value = false;

    try {
      final res = await _dio.post(
        "$baseURL/api/v1/training/getTraining?language=en",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
        data: {
          "training_id": id,
        },
      );

      if (res.statusCode == 200 && res.data["status"] == "success") {
        onSiteTraining.value = LiveTraining.fromJson(res.data["data"]);
      } else {
        isFailed.value = true;
        Get.snackbar(
            "Error", res.data["message"] ?? "Failed to fetch training.");
      }
    } on dio.DioException catch (e) {
      isFailed.value = true;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    } finally {
      isLoading.value = false;
    }
  }

  late final RxBool enrolled;
  Future<void> isEnrolled() async {
    dio.Dio d = dio.Dio();
    try {
      dio.Response r = await d.post(
        "$baseURL/api/v1/trainee/ensure_enrolled",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
        data: {
          "training_id": id,
        },
      );

      if (r.statusCode == 200 && r.data["status"] == "success") {
        enrolled.value = true;
      } else {
        enrolled.value = false;
      }
    } on dio.DioException catch (e) {
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }
}
