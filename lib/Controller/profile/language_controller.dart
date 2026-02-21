import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/app_localizations.dart';

class LanguageController extends GetxController {
  late BuildContext context;

  late List<Map<String, String>> languages;

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedLanguage();
  }

  void initLanguages(BuildContext context) {
    this.context = context;
    languages = [
      {'name': AppLocalizations.of(context)!.english, 'code': 'en'},
      {'name': AppLocalizations.of(context)!.arabic, 'code': 'ar'},
      {'name': AppLocalizations.of(context)!.deutsch, 'code': 'de'},
    ];
  }

  Future<void> selectLanguage(int index) async {
    selectedIndex.value = index;
    String code = languages[index]['code']!;
    Get.updateLocale(Locale(code));
    await saveSelectedLanguage(code);
  }

  Future<void> saveSelectedLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language_code', code);
  }

  Future<void> loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? code = prefs.getString('selected_language_code');
    if (code != null) {
      int index = languages.indexWhere((lang) => lang['code'] == code);
      if (index != -1) {
        selectedIndex.value = index;
        Get.updateLocale(Locale(code));
      }
    }
  }
}
