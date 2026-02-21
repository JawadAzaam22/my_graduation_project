
import 'package:get/get.dart';

import '../../Controller/auth/reset_password_controller.dart';



class ResetPasswordBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<ResetPasswordController>(ResetPasswordController());

  }

}