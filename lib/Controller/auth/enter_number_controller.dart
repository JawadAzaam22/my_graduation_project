import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:german_board/Constants/base_url.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:dio/dio.dart' as dio;
import '../../Services/service.dart';
import '../../l10n/app_localizations.dart';

class EnterNumberController extends GetxController {
  @override
  void onInit() {
    service = Get.find<UserService>();
    phoneController = TextEditingController();

    super.onInit();
  }

  late BuildContext context;
  late TextEditingController phoneController;
  final RxBool _isLoading = RxBool(false);
  late final UserService service;
  bool get isLoading => _isLoading.value;
  var formKey = GlobalKey<FormState>();
  Future<void> sendCode() async {
    print(selectedCountry.phoneCode + phoneController.text);
    dio.Dio d = dio.Dio();
    if (formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        update();
        dio.Response r =
            await d.post("$baseURL/api/v1/trainee/auth/forgetPassword", data: {
          "phone_number":
              "+${selectedCountry.phoneCode}${phoneController.text}",
        });
        if (r.statusCode == 200 && r.data["status"] == "success") {
          Get.toNamed("/otpResetPassword", arguments: {
            "phone_num": "+${selectedCountry.phoneCode}${phoneController.text}"
          });
        } else {
          Get.snackbar("Error", r.data["message"] ?? "error");
        }
        _isLoading.value = false;
        update();
      } on dio.DioException catch (e) {
        _isLoading.value = false;
        update();
        Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      }
    }
  }

  Future<void> sendCodeRegister() async {
    print(selectedCountry.phoneCode + phoneController.text);
    dio.Dio d = dio.Dio();
    if (formKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        dio.Response r = await d.post("$baseURL/api/v1/auth/askForOTP", data: {
          "phone_number":
              "+${selectedCountry.phoneCode}${phoneController.text}",
        });
        if (r.statusCode == 200) {
          Get.toNamed("/otpRegister", arguments: {
            "phone_num": "+${selectedCountry.phoneCode}${phoneController.text}"
          });
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

  void toBack() {
    Get.back();
  }

  Country selectedCountry = Country(
    phoneCode: "49",
    countryCode: "DE",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Germany",
    example: "15123456789",
    displayName: "Germany (+49)",
    displayNameNoCountryCode: "Germany",
    e164Key: "49",
  );

  String? phoneValidator(value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.required;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phoneController.text)) {
      return 'يجب أن يحتوي الرقم على أرقام فقط';
    }
    if (value.length < 6 || value.length > 15) {
      return 'رقم الهاتف غير صالح';
    }
    return null;
  }
}
