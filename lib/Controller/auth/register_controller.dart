import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../Constants/base_url.dart';
import '../../l10n/app_localizations.dart';

class RegisterController extends GetxController {
  late BuildContext context ;
  @override
  void onInit() {

    emailController = TextEditingController(text: "name@example.com");
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    super.onInit();
  }

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;
  late TextEditingController addressController;

  var formKey = GlobalKey<FormState>();
  var dateOfBirth = '2/2/2002'.obs;
  late var selectedGender = AppLocalizations.of(context)!.male.obs;
  var selectedCountry = 'Germany'.obs;
  var dialCode = Get.arguments["code"].toString();
  var phoneNumber = Get.arguments["phoneNum"];
  final RxBool _isLoading = RxBool(false);
  late List<String> genders = [AppLocalizations.of(context)!.male, AppLocalizations.of(context)!.female, AppLocalizations.of(context)!.other];

  bool get isLoading => _isLoading.value;
  dynamic setGender(String? gender) {
    selectedGender.value = gender!;
    update();
  }

  void setCountry(Country country) {
    selectedCountry.value = country.name;
    dialCode = country.phoneCode;
    update();
  }

  void setDateOfBirth(DateTime pickedDate) {
    dateOfBirth.value =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    update();
  }

  RxBool isObscure = RxBool(true);
  void changeIsPass() {
    isObscure.value = !isObscure.value;
  }


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
    } else
      if (!EmailValidator.validate(emailController.text)) {
      return AppLocalizations.of(context)!.invalid_email;
    }
    return null;
  }

  String? getPasswordFeedback(value) {
    if (passwordController.text.isEmpty) {
      return AppLocalizations.of(context)!.required;
    } else {
      if (passwordController.text.length < 8) {
        return  AppLocalizations.of(context)!.numberPasswordLetters;
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
      if (!passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return AppLocalizations.of(context)!.testSpecialCharacter;
      }
    }
    return null;
  }

  Future<void> signUP() async {
    dio.Dio d = dio.Dio();
    if (formKey.currentState!.validate()) {
      try {
        dio.FormData formData = dio.FormData.fromMap({
          "first_name": firstNameController.text,
          "last_name":lastNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "password_confirmation": passwordConfirmationController.text,
          "phone_number":dialCode+phoneNumber,//.value
          "gender":selectedGender.value,
          "date_of_birth":dateOfBirth.value,
          "country":selectedCountry.value ,
          "address": addressController.text
        });

        _isLoading.value = true;
        dio.Response r = await d.post("$baseURL/api/v1/register", data: formData

        );

        if (r.statusCode == 201) {
          Get.offAndToNamed("/AccountCreated"
       );
          _isLoading.value = false;
        } else {
          Get.snackbar("Error", r.data["message"] ?? "An error occurred");
        }
        _isLoading.value = false;
      } on dio.DioException catch (e) {
        _isLoading.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      }
    }
  }

}
