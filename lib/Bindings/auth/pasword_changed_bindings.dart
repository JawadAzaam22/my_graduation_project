
import 'package:get/get.dart';
import '../../Controller/auth/password_changed_controller.dart';

class PasswordChangedBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<PasswordChangedController>(PasswordChangedController());

  }

}