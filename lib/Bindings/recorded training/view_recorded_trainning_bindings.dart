import 'package:german_board/Controller/recorded_training/view_recorded_trainning_controller.dart';
import 'package:get/get.dart';

class ViewRecordedTrainningBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ViewRecordedTrainningController>(ViewRecordedTrainningController());
  }

}