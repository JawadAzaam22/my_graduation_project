

import 'package:get/get.dart';

import '../../Controller/auth/log_in_with_google_controller.dart';
import '../../Controller/auth/login_controller.dart';

class LoginBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put<LogInWithGoogleController>(LogInWithGoogleController());
  }

}