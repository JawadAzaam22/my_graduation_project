
import 'package:get/get.dart';

import '../../Controller/profile/change_pass_security_controller.dart';

class ChangePassSecurityBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<ChangePassSecurityController>(ChangePassSecurityController());


  }

}