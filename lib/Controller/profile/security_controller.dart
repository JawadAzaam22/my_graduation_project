import 'package:get/get.dart';

class SecurityController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
  RxBool rememberMe = true.obs;
  void navToChangePassSec(){
    Get.toNamed("/changePassSec");
  }
}
