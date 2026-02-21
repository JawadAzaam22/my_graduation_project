

import 'package:german_board/profile/user_profile_controller.dart';
import 'package:get/get.dart';


class UserProfileBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<UserProfileController>(UserProfileController());


  }

}