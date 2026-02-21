
import 'package:get/get.dart';

import '../../Controller/recorded_training/quiz_controller.dart';

class QuizBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<QuizController>(QuizController());
  }

}