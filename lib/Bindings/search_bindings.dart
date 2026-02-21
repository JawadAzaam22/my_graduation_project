

import 'package:get/get.dart';

import '../Controller/search_controller.dart';

class SearchBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<SearchAController>(SearchAController());
  }

}