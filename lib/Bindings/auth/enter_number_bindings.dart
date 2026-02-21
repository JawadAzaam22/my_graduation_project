import 'package:get/get.dart';
import '../../Controller/auth/enter_number_controller.dart';

class EnterNumberBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<EnterNumberController>(EnterNumberController());

  }

}