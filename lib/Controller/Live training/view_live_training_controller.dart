import 'package:german_board/Constants/base_url.dart';
import 'package:get/get.dart';
import '../../Models/live_training/Live_training.dart';
import '../../Services/service.dart';
import 'package:dio/dio.dart' as dio;

class ViewLiveTrainingController extends GetxController {
  late final UserService service;
  final RxBool isShortText = false.obs;
  final RxBool isExpanded = false.obs;
  final RxBool isLoading = true.obs;
  final RxBool isFailed = false.obs;

  void toggleDescription() => isExpanded.toggle();
  final liveTraining = Rxn<LiveTraining>();
  final dio.Dio _dio = dio.Dio();

  @override
  void onInit() async {
    super.onInit();
    service = Get.find<UserService>();
    id = Get.arguments["id"];
    await getCourseDetails();
    await isEnrolled();
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
        liveTraining.value = LiveTraining.fromJson(res.data["data"]);
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

  void navToViewProfile(int id) {
    Get.toNamed("/userprofiles", arguments: {
      "id": id,
    });
  }

  void navToViewCourse(String type, int id) {
    if (type == "recorded") {
      Get.toNamed("/viewEnrolledRecordedCourse", arguments: {
        "id": id,
      });
    }
    if (type == "live") {
      Get.toNamed("/ViewCourse", arguments: {
        "id": id,
      });
    }
  }

  late final RxBool enrolled = RxBool(true);
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
        enrolled.value = r.data["data"];
        update();
      }
    } on dio.DioException catch (e) {
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }
}
