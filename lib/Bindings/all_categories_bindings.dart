
import 'package:german_board/Controller/all_categories_controller.dart';
import 'package:get/get.dart';


class AllCategoriesBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<AllCategoriesController>(AllCategoriesController());


  }

}