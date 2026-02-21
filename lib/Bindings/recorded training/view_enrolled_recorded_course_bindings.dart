import 'package:german_board/Controller/recorded_training/view_enrolled_recorded_course_controller.dart';
import 'package:get/get.dart';

class ViewEnrolledRecordedCourseBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ViewEnrolledRecordedCourseController>(ViewEnrolledRecordedCourseController());
  }

}