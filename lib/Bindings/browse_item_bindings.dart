import 'package:german_board/Controller/browse_item_controller.dart';
import 'package:get/get.dart';

class BrowseItemBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<BrowseItemController>(BrowseItemController());
  }

}