import 'package:get/get.dart';
import '../../Controller/auth/log_in_with_google_controller.dart';
import '../../Controller/auth/welcome-controller.dart';

class WelcomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController());
    Get.put<LogInWithGoogleController>(LogInWithGoogleController());
  }
}