import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../l10n/app_localizations.dart';

class EditProfileController extends GetxController {
  @override
  void onInit() {
    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    super.onInit();
  }

  var formKey = GlobalKey<FormState>();
  late BuildContext context;
  late TextEditingController addressController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  final RxBool isLoading = RxBool(false);
  var dateOfBirth = '2/2/2002'.obs;
  var selectedCountry1 = 'Germany'.obs;
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

  var dialCode = '+880'.obs;
  var phoneNumber = '0935272154';
  late List<String> genders = [
    AppLocalizations.of(context)!.male,
    AppLocalizations.of(context)!.female,
    AppLocalizations.of(context)!.other
  ];
  late var selectedGender = AppLocalizations.of(context)!.male.obs;
  void setDateOfBirth(DateTime pickedDate) {
    dateOfBirth.value =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    update();
  }

  dynamic setGender(String? gender) {
    selectedGender.value = gender!;
    update();
  }

  void setCountry(Country country) {
    selectedCountry1.value = country.name;
    dialCode.value = country.phoneCode;
    update();
  }

  String? isValidEmail(email) {
    if (email == null || email.isEmpty) {
      return AppLocalizations.of(context)!.required;
    } else if (!EmailValidator.validate(emailController.text)) {
      return AppLocalizations.of(context)!.invalid_email;
    }
    return null;
  }

  File? image2;

  final imagePicker2 = ImagePicker();
  uploadImage2() async {
    var pickedImage = await imagePicker2.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image2 = File(pickedImage.path);
      update();
    } else {}
  }
}
