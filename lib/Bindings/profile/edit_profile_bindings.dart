import 'package:german_board/Controller/profile/edit_profile_controller.dart';
import 'package:get/get.dart';

import '../../Controller/profile/my_profile_controller.dart';


class EditProfileBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<EditProfileController>(EditProfileController());


  }

}