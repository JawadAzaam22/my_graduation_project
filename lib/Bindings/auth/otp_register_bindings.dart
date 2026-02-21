
import 'package:german_board/Controller/auth/otp_register_controller.dart';
import 'package:get/get.dart';


class  OtpRegisterBindings implements Bindings {

  @override
  void dependencies() {

    Get.put<OtpRegisterController>(OtpRegisterController());




  }

}