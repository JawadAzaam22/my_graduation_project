import 'package:german_board/Controller/auth/otp_reset_password_controller.dart';
import 'package:get/get.dart';


class  OtpResetPasswordBindigs implements Bindings {

  @override
  void dependencies() {

    Get.put<OtpResetPasswordController>(OtpResetPasswordController());




  }

}