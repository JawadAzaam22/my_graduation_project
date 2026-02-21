import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../Constants/base_url.dart';
import '../../Models/blogs/one_blog.dart';
import '../../Services/service.dart';

class BlogsController extends GetxController {
  late final UserService service;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final RxList<BlogModel> blogs = <BlogModel>[].obs;

  final RxList<String> filters = <String>['All'].obs;
  final RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    service = Get.find<UserService>();
    super.onInit();
    getAllBlogs();
  }

  List<BlogModel> get filteredBlogs {
    if (selectedFilter.value == 'All') {
      return blogs;
    } else {
      return blogs
          .where((blog) => blog.categories.contains(selectedFilter.value))
          .toList();
    }
  }

  List<BlogModel> get recommendedBlogs => blogs.take(2).toList();

  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  void navToViewBlog(int blogID) async {
    await addView(blogID);
    Get.toNamed("/viewBlog", arguments: {"blogID": blogID});
   getAllBlogs();
  }

  Future<void> getAllBlogs() async {
    dio.Dio d = dio.Dio();

    try {
      _isLoading.value = true;
      dio.Response r = await d.get(
        "$baseURL/api/v1/trainee/blogs/getAll",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
      );

      if (r.statusCode == 200 && r.data["status"] == "success") {
        blogs.clear();
        filters.clear();

        List<dynamic> data = r.data["data"]["data"];
        blogs.value = data.map((json) => BlogModel.fromJson(json)).toList();

        final allCategories =
            blogs.expand((b) => b.categories).toSet().toList();
        filters.value = ['All', ...allCategories];
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
      _isLoading.value = false;
    } on dio.DioException catch (e) {
      _isLoading.value = false;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> addView(int blogID) async {
    dio.Dio d = dio.Dio();
    try {
      dio.Response r = await d.post(
        "$baseURL/api/v1/all/addView",
        options: dio.Options(
          headers: {"Authorization": "Bearer ${service.token}"},
        ),
        data: {
          "global_article_id": blogID,
        },
      );

      if (r.statusCode == 200 && r.data["status"] == "success") {
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
    } on dio.DioException catch (e) {
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> handleRefresh() async {
    await getAllBlogs();
  }
}
