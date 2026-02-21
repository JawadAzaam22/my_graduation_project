import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PasswordChangedController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void navToLogin() {
    Get.offAllNamed("/Login");
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
}
