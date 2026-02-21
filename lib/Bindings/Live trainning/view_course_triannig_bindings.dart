import 'package:german_board/Controller/Live%20training/view_course_triannig_controller.dart';
import 'package:get/get.dart';

class ViewCourseTriannigBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ViewCourseTriannigController>(ViewCourseTriannigController());
  }

}