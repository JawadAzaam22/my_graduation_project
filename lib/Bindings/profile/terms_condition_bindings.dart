import 'package:german_board/Controller/profile/terms_conditions_controller.dart';
import 'package:get/get.dart';

class TermsConditionBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<TermsConditionsController>(TermsConditionsController());


  }

}