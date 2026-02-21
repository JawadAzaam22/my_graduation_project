import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/service.dart';

class MyProfileController extends GetxController {
  @override
  void onInit() {
    service = Get.find<UserService>();
    super.onInit();
    getThemeMode();
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

  RxBool isDarkMode = RxBool(false);

  void getThemeMode() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode == AdaptiveThemeMode.dark) {
      isDarkMode.value = true;
    } else {
      isDarkMode.value = false;
    }
  }

  void navToEditProfile() {
    Get.toNamed("/editProfile");
  }

  void navToSecurity() {
    Get.toNamed("/security");
  }

  void navToLanguage() {
    Get.toNamed("/language");
  }

  void navToSettingNotify() {
    Get.toNamed("/settingNotify");
  }

  void navToTermsAndCondition() {
    Get.toNamed("/termsAndCondition");
  }

  void navToSearchCertificate() {
    Get.toNamed("/searchCertificate");
  }

  void navToComplaint() {
    Get.toNamed("/addComplaint");
  }

  late final UserService service;
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
    service.currentUser = null;
    service.token = null;
    Get.offAllNamed('/splash');
  }
}
