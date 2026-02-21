import 'package:german_board/Controller/my_courses/my_courses_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LayoutController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
  RxInt navIndex=RxInt(0);
  Future<void> changIndex(index) async {
    navIndex.value=index;

    if( navIndex.value==1){
      Get.delete<MyCoursesController>();
      Get.put<MyCoursesController>(MyCoursesController());
    }
    update();
  }
}