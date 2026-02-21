import 'package:get/get.dart';
import '../../Constants/base_url.dart';
import '../../Models/blogs/one_blog.dart';
import '../../Services/service.dart';
import 'package:dio/dio.dart' as dio;

class ViewBlogController extends GetxController {
  late final UserService service;
  late int blogID;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final Rxn<BlogModel> blog = Rxn<BlogModel>();

  @override
  void onInit() {
    super.onInit();
    service = Get.find<UserService>();
    blogID = Get.arguments["blogID"];
    getBlogByID();
  }

  Future<void> getBlogByID() async {
    dio.Dio d = dio.Dio();

    try {
      _isLoading.value = true;
      dio.Response r = await d.get(
        "$baseURL/api/v1/trainee/blogs/$blogID",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
      );

      if (r.statusCode == 200 && r.data["status"] == "success") {
        blog.value = BlogModel.fromJson(r.data["data"]);
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
    } on dio.DioException catch (e) {
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    } finally {
      _isLoading.value = false;
    }
  }
}
