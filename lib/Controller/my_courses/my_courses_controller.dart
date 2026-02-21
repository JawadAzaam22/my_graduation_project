import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/base_url.dart';
import '../../Models/my_courses/MyCourse.dart';
import '../../Services/service.dart';

class MyCoursesController extends GetxController {
  var isLiveSelected = false.obs;
  var recordedCourses = <Course>[].obs;
  var liveCourses = <Course>[].obs;
  late final UserService service;
  var isLoading = false.obs;

  @override
  void onInit() async {
    service = Get.find<UserService>();
    await fetchTrainings();
    super.onInit();
  }

  RxBool noCourses(bool liveSelected) {
    if (recordedCourses.isEmpty && !isLiveSelected.value) {
      return true.obs;
    } else if (liveCourses.isEmpty && isLiveSelected.value) {
      return true.obs;
    } else {
      return false.obs;
    }
  }

  void updateSelected(bool isLive) {
    isLiveSelected.value = isLive;
  }

  Future<void> fetchTrainings() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    isLoading.value = true;
    try {
      dio.Dio d = dio.Dio();
      final response = await d.get(
        '$baseURL/api/v1/trainee/training',
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        queryParameters: {'language': 'en'},
      );
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final myCourses = MyCourses.fromJson(response.data);
        recordedCourses.value = myCourses.recorded;
        liveCourses.value = myCourses.live;
      } else {
        Get.snackbar('خطأ', 'فشل في تحميل البيانات');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void>handleRefresh()async
  {
    await fetchTrainings();

  }

  void navToViewCourse(String type, int id) {
    if (type == "recorded") {
      Get.toNamed("/viewRecordedCourse", arguments: {
        "id": id,
      });
    }
    if (type == "live") {
      Get.toNamed("/view", arguments: {
        "id": id,
      });
    }
  }
}
