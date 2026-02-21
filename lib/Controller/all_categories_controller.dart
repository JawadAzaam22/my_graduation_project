import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constants/base_url.dart';
import '../Models/live_training/home_training.dart';
import '../Models/one_course.dart';
import '../Services/service.dart';
import 'package:dio/dio.dart' as dio;

class AllCategoriesController extends GetxController {
  @override
  void onInit() async {
    service = Get.find<UserService>();

    categories.assignAll(Get.arguments["cat"] as List<Category>);

    super.onInit();
  }

  late final UserService service;

  RxList<Category> categories = <Category>[].obs;

  RxString searchQuery = ''.obs;

  List<Category> get filteredCategories {
    if (searchQuery.value.isEmpty) return categories;
    return categories
        .where((cat) =>
            cat.name!.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;
  RxList<OneCourse> categoryCourses = RxList([]);
  Future<void> getCoursesOfCategory(int id) async {
    dio.Dio d = dio.Dio();

    try {
      _isLoading.value = true;
      dio.Response r = await d.get(
        "$baseURL/api/v1/trainee/training/by-category/$id",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
      );
      if (r.statusCode == 200 && r.data["status"] == "success") {
        categoryCourses.clear();
        List<dynamic> data = r.data["data"];

        List<OneCourse> courses =
            data.map((item) => OneCourse.fromJson(item)).toList();

        categoryCourses.value = courses;
        navToSeeAllCourses(categoryCourses.value);
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
      _isLoading.value = false;
    } on dio.DioException catch (e) {
      _isLoading.value = false;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  void navToSeeAllCourses(List<OneCourse> courses) {
    Get.toNamed("/browse", arguments: {
      "courses": courses,
    });
  }
}
