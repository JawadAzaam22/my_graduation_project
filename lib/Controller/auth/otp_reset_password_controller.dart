import 'dart:async';
import 'package:flutter/material.dart';
import 'package:german_board/Constants/base_url.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio;

class OtpResetPasswordController extends GetxController {
  var isError = false.obs;
  var remainingTime = 20.obs;
  var isResendEnabled = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    otpController = TextEditingController();
    super.onInit();
    phoneNum = Get.arguments["phone_num"];
    startResendTimer();
  }

  late TextEditingController otpController;
  late String phoneNum;
  void startResendTimer() {
    remainingTime.value = 20;
    isResendEnabled.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        isResendEnabled.value = true;
        _timer?.cancel();
      }
    });
  }

  void navToResetPassword() {
    Get.offAndToNamed("/ResetPassword");
  }

  bool get isLoading => _isLoading.value;
  final RxBool _isLoading = RxBool(false);

  Future<void> verifyOTP() async {
    dio.Dio d = dio.Dio();
    try {
      _isLoading.value = true;
      dio.Response r =
          await d.post("$baseURL/api/v1/trainee/auth/checkCode", data: {
        "phone_number": phoneNum,
        "code": int.tryParse(otpController.text),
      });

      if (r.statusCode == 200 && r.data["status"] == "success") {
        isError.value = false;
        navToResetPassword();
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
        isError.value = true;
      }
      _isLoading.value = false;
    } on dio.DioException catch (e) {
      _isLoading.value = false;
      isError.value = true;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> resendOTP() async {
    dio.Dio d = dio.Dio();
    try {
      dio.Response r = await d
          .post("$baseURL/api/v1/trainee/auth/resendForgetPasswordCode", data: {
        "phone_number": phoneNum,
      });

      if (r.statusCode == 200 && r.data["status"] == "success") {
        print("${r.data["data"]}");
        if (isResendEnabled.value) {
          startResendTimer();
        }
      }
    } on dio.DioException catch (e) {
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }
}
