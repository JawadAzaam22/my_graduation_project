import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
class change extends GetxController {
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