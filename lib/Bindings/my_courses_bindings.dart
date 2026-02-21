import 'package:german_board/Controller/my_courses/my_courses_controller.dart';
import 'package:get/get.dart';

class MyCoursesBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<MyCoursesController>(MyCoursesController());
  }

}