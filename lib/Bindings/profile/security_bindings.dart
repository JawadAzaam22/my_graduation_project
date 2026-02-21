import 'package:get/get.dart';

import '../../Controller/profile/my_profile_controller.dart';
import '../../Controller/profile/security_controller.dart';


class SecurityBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<SecurityController>(SecurityController());


  }

}