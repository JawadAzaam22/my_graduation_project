import 'package:german_board/changetheme/controllet.dart';
import 'package:get/get.dart';


class changeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<change>(change());
  }
}