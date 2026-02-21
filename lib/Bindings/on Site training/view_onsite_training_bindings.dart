import 'package:get/get.dart';

import '../../Controller/on Site training/view_onsite_training_controller.dart';

class ViewOnsiteTrainingBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ViewOnsiteTrainingController>(ViewOnsiteTrainingController());
  }

}