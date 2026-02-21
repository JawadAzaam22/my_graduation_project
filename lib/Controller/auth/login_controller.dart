import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:german_board/Constants/base_url.dart';
import 'package:german_board/Models/auth/trainee_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/service.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:convert';
import '../../l10n/app_localizations.dart';

class LoginController extends GetxController {
  @override
  void onInit() async {
    service = Get.find<UserService>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  late BuildContext context;

  String? isValidPasswordConfirmation(value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.validPasswordConfirmation;
    } else if (value != passwordController.text) {
      return AppLocalizations.of(context)!.validPassword;
    }
    return null;
  }

  String? isValidEmail(email) {
    if (email == null || email.isEmpty) {
      return AppLocalizations.of(context)!.required;
    } else if (!EmailValidator.validate(emailController.text)) {
      return AppLocalizations.of(context)!.invalid_email;
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

  late TextEditingController emailController;
  late TextEditingController passwordController;

  RxBool isObscure = RxBool(true);
  void changeIsPass() {
    isObscure.value = !isObscure.value;
  }

  var formKey = GlobalKey<FormState>();
  void navToSignUp() {
    Get.toNamed("/CreateAccNumber");
  }

  void navToEnterNum() {
    Get.toNamed("/ForgetPassword");
  }

  void toBack() {
    Get.back();
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

  final RxBool _isLoading = RxBool(false);
  late final UserService service;
  bool get isLoading => _isLoading.value;
  Future<void> saveLoginInfo(TraineeModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    await prefs.setString('token', token);
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceToken= prefs.getString('fcmToken');
    dio.Dio d = dio.Dio();
    if (formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        dio.Response r = await d.post("$baseURL/api/v1/auth/login", data: {
          "email": emailController.text,
          "password": passwordController.text,
          "device_token": deviceToken!

        });
        if (r.statusCode == 200 && r.data["status"] == "success") {
          Map<String, dynamic> userData = r.data['data'];
          service.currentUser = TraineeModel.fromJson(userData);

          service.token = r.data['data']['access_token'];

          await saveLoginInfo(service.currentUser!, service.token!);
          print(service.token.toString());
          Get.offAllNamed("/layout");
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

  final RxBool _isLoadingG = RxBool(false);

  bool get isLoadingG => _isLoadingG.value;

  Future<void> removeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
    service.currentUser = null;
    service.token = null;
    Get.offAllNamed('/splash');
  }

  final RxBool _isLoadingLogout = RxBool(false);
  bool get isLoadingLogout => _isLoadingLogout.value;
  Future<void> logout() async {
    dio.Dio d = dio.Dio();
    if (formKey.currentState!.validate()) {
      try {
        _isLoadingLogout.value = true;
        dio.Response r = await d.post("$baseURL/api/v1/auth/logout",
            options: dio.Options(
              headers: {
                "Authorization": "Bearer ${service.token}",
              },
            ),
            data: {});
        if (r.statusCode == 200 && r.data["status"] == "success") {
          await removeData();
        } else {
          Get.snackbar("Error", r.data["message"] ?? "error");
        }
        _isLoadingLogout.value = false;
      } on dio.DioException catch (e) {
        _isLoadingLogout.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      }
    }
  }
}
