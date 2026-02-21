import 'package:german_board/Controller/profile/language_controller.dart';
import 'package:get/get.dart';

import '../../Controller/profile/my_profile_controller.dart';


class LanguageBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<LanguageController>(LanguageController());


  }

}