import 'dart:convert';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/base_url.dart';
import '../../Models/auth/trainee_model.dart';
import '../../Services/service.dart';
import '../../l10n/app_localizations.dart';

class LogInWithGoogleController extends GetxController {
  late BuildContext context;
  @override
  void onInit() {
    service = Get.find<UserService>();
    super.onInit();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
  }

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  var formKey = GlobalKey<FormState>();
  var dateOfBirth = '2/2/2002'.obs;
  late var selectedGender = AppLocalizations.of(context)!.male.obs;
  var selectedCountry = 'Germany'.obs;
  var dialCode = '+880'.obs;
  final RxBool _isLoading = RxBool(false);
  late final UserService service;
  bool get isLoading => _isLoading.value;
  late List<String> genders = [
    AppLocalizations.of(context)!.male,
    AppLocalizations.of(context)!.female,
    AppLocalizations.of(context)!.other
  ];
  late String? email;

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
    selectedCountry.value = country.name;
    dialCode.value = country.phoneCode;
    update();
  }

  Future<void> saveLoginInfo(TraineeModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
    await prefs.setString('token', token);
  }

  Future<void> signInWithGoogle() async {
    _isLoading.value = true;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    dio.Dio d = dio.Dio();
    dio.FormData formData =
        dio.FormData.fromMap({"email": userCredential.user?.email});
    try {
      dio.Response r = await d.post(
        "$baseURL/api/v1/google/checkEmailExistence",
        data: formData,
        options: dio.Options(
          validateStatus: (status) => true,
        ),
      );
      print(r.statusCode);
      if (r.statusCode == 200) {
        Map<String, dynamic> userData = r.data['data'];
        service.currentUser = TraineeModel.fromJson(userData);
        service.token = r.data['data']['access_token'];
        await saveLoginInfo(service.currentUser!, service.token!);
        Get.offAllNamed("/layout");
        _isLoading.value = false;
      } else if (r.statusCode == 500 || r.data["message"]=="user not found") {
        print(userCredential.user?.email);
        email = userCredential.user?.email;
        Get.toNamed("/LoginWithGoogle");
      } else {
        Get.snackbar("Error", "An error occurred");
      }
      _isLoading.value = false;
    } on dio.DioException catch (e) {
      _isLoading.value = false;
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  Future<void> sendUserInformation() async {
    dio.Dio d = dio.Dio();
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      try {
        dio.FormData formData = dio.FormData.fromMap({
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "email": email,
          "phone_number": dialCode.value + phoneController.text,
          "gender": selectedGender.value,
          "date_of_birth": dateOfBirth.value,
          "country": selectedCountry.value,
          "address": addressController.text
        });
        dio.Response r =
            await d.post("$baseURL/api/v1/google/register", data: formData);
        if (r.statusCode == 201) {
          Map<String, dynamic> userData = r.data['data'];
          service.currentUser = TraineeModel.fromJson(userData);
          service.token = r.data['data']['access_token'];
          await saveLoginInfo(service.currentUser!, service.token!);
          Get.offAllNamed("/layout");
          _isLoading.value = false;
        } else {
          Get.snackbar("Error", r.data["message"] ?? "An error occurred");
          _isLoading.value = false;
        }
      } on dio.DioException catch (e) {
        _isLoading.value = false;
        Get.snackbar("Error", e.response?.data["message"] ?? e.message);
      }
    }
  }
}
