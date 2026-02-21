import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:german_board/Constants/base_url.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../Services/service.dart';
import 'package:dio/dio.dart' as dio;
import '../../l10n/app_localizations.dart';

class ChangePassSecurityController extends GetxController {
  @override
  void onInit() {
    service = Get.find<UserService>();
    conformPasswordController = TextEditingController();
    passwordController = TextEditingController();
    oldPasswordController = TextEditingController();
    super.onInit();
  }

  late TextEditingController oldPasswordController;
  late TextEditingController conformPasswordController;
  late TextEditingController passwordController;
  late BuildContext context;
  void toBack() {
    Get.back();
  }

  RxBool isObscure = RxBool(true);
  void changeIsPass() {
    isObscure.value = !isObscure.value;
  }

  RxBool isObscure1 = RxBool(true);
  void changeIsPass1() {
    isObscure1.value = !isObscure1.value;
  }

  RxBool isObscure2 = RxBool(true);
  void changeIsPass2() {
    isObscure2.value = !isObscure2.value;
  }

  var formKey = GlobalKey<FormState>();

  final RxBool _isLoading = RxBool(false);
  late final UserService service;
  bool get isLoading => _isLoading.value;
  Future<void> resetPassword() async {
    dio.Dio d = dio.Dio();
    if (formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        dio.Response r = await d.post("$baseURL/api/v1/auth/resetPassword",
            options: dio.Options(
              headers: {
                "Authorization": "Bearer ${service.token}",
              },
            ),
            data: {
              "password": passwordController.text,
              "password_confirmation": conformPasswordController.text,
            });
        if (r.statusCode == 200 && r.data["status"] == "success") {
          Get.offAndToNamed("/PasswordChanged");
        } else {
          Get.snackbar("Error", r.data["message"] ?? "error");
        }
        _isLoading.value = false;
      } on dio.DioException catch (e) {
        _isLoading.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      }
    }
  }

  RxBool isDarkMode = RxBool(false);
  void getThemeMode() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode == AdaptiveThemeMode.dark) {
      isDarkMode.value = true;
    } else {
      isDarkMode.value = false;
    }
  }

  String? isValidPasswordConfirmation(value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.validPasswordConfirmation;
    } else if (value != passwordController.text) {
      return AppLocalizations.of(context)!.validPassword;
    }
    return null;
  }

  String? getPasswordFeedback(value) {
    if (passwordController.text.isEmpty) {
      return AppLocalizations.of(context)!.required;
    } else {
      if (passwordController.text.length < 8) {
        return AppLocalizations.of(context)!.numberPasswordLetters;
      }
      if (!passwordController.text.contains(RegExp(r'[A-Z]'))) {
        return AppLocalizations.of(context)!.testUppercaseLetter;
      }
      if (!passwordController.text.contains(RegExp(r'[a-z]'))) {
        return AppLocalizations.of(context)!.testLowercaseLetter;
      }
      if (!passwordController.text.contains(RegExp(r'[0-9]'))) {
        return AppLocalizations.of(context)!.testNumber;
      }
      if (!passwordController.text
          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return AppLocalizations.of(context)!.testSpecialCharacter;
      }
    }
    return null;
  }
}
