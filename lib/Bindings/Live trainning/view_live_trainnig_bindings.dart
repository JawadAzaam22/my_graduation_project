import 'package:german_board/Controller/Live%20training/view_live_training_controller.dart';
import 'package:get/get.dart';

class ViewLiveTrainnigBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ViewLiveTrainingController>(ViewLiveTrainingController());
  }

}