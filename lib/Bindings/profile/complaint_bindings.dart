import 'package:get/get.dart';

import '../../Controller/profile/complaint_controller.dart';



class ComplaintBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<ComplaintController>(ComplaintController());


  }

}