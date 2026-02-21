import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:german_board/Models/blogs/one_blog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/service.dart';
import 'package:dio/dio.dart' as dio;

import '../Constants/base_url.dart';

import '../Models/live_training/home_training.dart';
import '../Models/one_course.dart';
class HomeController extends GetxController {
  @override
  void onInit()async {
    service = Get.find<UserService>();
   await loadSelectedLanguage();
    await getHome();
    //await getAllBlogs();
    super.onInit();
  }


  RxBool isDarkMode=RxBool(false);
  void getThemeMode()async{
    final savedThemeMode=await AdaptiveTheme.getThemeMode();
    if(savedThemeMode == AdaptiveThemeMode.dark){

      isDarkMode.value=true;

    }else {

      isDarkMode.value=false;

    }

  }
  final RxBool _isLoading = RxBool(false);
  late final UserService service;
  bool get isLoading => _isLoading.value;
  final RxBool _isLoadingCatCourse = RxBool(false);

  bool get isLoadingCatCourse => _isLoadingCatCourse.value;
  void navToSearch(){
    Get.toNamed("/search");
  }
  RxList<Category>categories=RxList([]);
  RxList<OneCourse>allCourses=RxList([]);

  Future<void> loadSelectedLanguage() async {

  final prefs = await SharedPreferences.getInstance();

  String? code = prefs.getString('selected_language_code');
  if(code=="de"){
    s="du";
  }else if(code=="ar")
   { s="ar";}else{s="en";}

}
late String s ;

  Future<void> getHome() async {
    dio.Dio d = dio.Dio();

      try {
        _isLoading.value = true;
        dio.Response r = await d.get("$baseURL/api/v1/home?language=$s",
            options: dio.Options(
              headers: {
                "Authorization": "Bearer ${service.token}",
              },
            ),
        );
        if (r.statusCode == 200 && r.data["status"] == "success") {

          categories.clear();
          allCourses.clear();

          List cats = r.data['data']['categories'];

          categories.addAll(cats.map((e) => Category.fromJson(e)).toList());
          List training = r.data['data']['trainings'];
          allCourses.addAll(training.map((e) => OneCourse.fromJson(e)).toList());

        }


         else {
          Get.snackbar("Error", r.data["message"] ?? "error");
        }
        _isLoading.value = false;
      } on dio.DioException catch (e) {
        _isLoading.value = false;
        print("eeeeeeeeeeeeeeeee");
        Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      }

  }


  void navToSeeAllCategories(List<Category>cat){
    Get.toNamed("/allCategories",arguments: {
      "cat":cat,
    });
  }


  RxList<OneCourse>categoryCourses=RxList([]);
  Future<void> getCoursesOfCategory(int id) async
  {
    dio.Dio d = dio.Dio();

    try {
      _isLoadingCatCourse.value = true;
      dio.Response r = await d.get("$baseURL/api/v1/trainee/training/by-category/$id",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },),
      );
      if (r.statusCode == 200 && r.data["status"] == "success") {

        categoryCourses.clear();
        List<dynamic> data = r.data["data"];

        List<OneCourse> courses = data.map((item) => OneCourse.fromJson(item)).toList();

        categoryCourses.value = courses;
        print(categoryCourses.value);
        navToSeeAllCourses(categoryCourses.value);




      }


      else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
      _isLoadingCatCourse.value = false;
    } on dio.DioException catch (e) {
      _isLoadingCatCourse.value = false;
      print("eeeeeeeeeeeeeeeee");
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }

  }


  void navToSeeAllCourses(List<OneCourse>courses){
    Get.toNamed("/browse",arguments: {
      "courses":courses,
    });
  }

  void navAllCourses(List<OneCourse>courses){
    Get.toNamed("/browse",arguments: {
      "courses":courses,
    });
  }

  void navToViewCourse(String type,int id){
    if(type=="recorded"){
      Get.toNamed("/viewRecordedCourse",arguments: {
        "id":id,
      });

    }
    if(type=="live"){
      Get.toNamed("/view",arguments: {
        "id":id,
      });
    }
    if(type=="onsite"){
      Get.toNamed("/viewOnSiteCourse",arguments: {
        "id":id,
      });
    }

  }

  /////////////blogs

  void navToViewBlog(int blogID) async{
    print("clickkkk");
    await addView(blogID);
    Get.toNamed("/viewBlog",arguments:{
      "blogID":blogID

    });
    getAllBlogs();


  }
  final RxList<BlogModel> blogs = <BlogModel>[].obs;
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



        List<dynamic> data = r.data["data"]["data"];
        blogs.value = data.map((json) => BlogModel.fromJson(json)).toList();
       blogs.assignAll(data.map((json) => BlogModel.fromJson(json)).toList());


        final allCategories = blogs.expand((b) => b.categories).toSet().toList();

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
        print("donnnnne");

      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");

      }
    } on dio.DioException catch (e) {

      Get.snackbar("Error", e.response?.data["message"] ?? e.message);

    }
  }

Future<void>handleRefresh()async
{
  await loadSelectedLanguage();
  await getHome();
  await getAllBlogs();

  //return await Future.delayed(Duration(seconds: 2));
}
}