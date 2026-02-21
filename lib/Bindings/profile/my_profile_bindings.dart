import 'package:get/get.dart';

import '../../Controller/profile/my_profile_controller.dart';


class MyProfileBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<MyProfileController>(MyProfileController());


  }

}