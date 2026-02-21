import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/auth/trainee_model.dart';
import '../../Services/service.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() async {
    service = Get.find<UserService>();
    bool isLoggedIn = await checkLoginStatus();
    isLoggedIn ? Get.offAndToNamed("/layout") : Get.toNamed("/welcome");
    // TODO: implement onInit
    super.onInit();
  }

  late final UserService service;
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    final String? token = prefs.getString('token');

    if (userString != null && token != null) {
      Map<String, dynamic> userMap = jsonDecode(userString);
      service.currentUser = TraineeModel.fromJson(userMap);
      service.token = token;
      return true;
    }
    return false;
  }

  void navToLogIn() {
    Get.toNamed("/Login");
  }

  void navToRegister() {
    Get.toNamed("/CreateAccNumber");
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      Get.toNamed("/layout");
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }
}
