import 'package:german_board/Controller/home_controller.dart';
import 'package:german_board/Controller/layout_controller.dart';
import 'package:german_board/Controller/profile/my_profile_controller.dart';
import 'package:get/get.dart';
import '../Controller/blogs/blogs_controller.dart';
import '../Controller/my_courses/my_courses_controller.dart';
import '../Controller/notifications_controller.dart';

class LayoutBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<LayoutController>(LayoutController());
    Get.put<HomeController>(HomeController());
    Get.put<BlogsController>(BlogsController());
    Get.put<MyProfileController>(MyProfileController());
    Get.lazyPut(()=>MyCoursesController());
  }

}