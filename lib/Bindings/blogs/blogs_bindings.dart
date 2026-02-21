import 'package:german_board/Controller/blogs/blogs_controller.dart';
import 'package:get/get.dart';

class BlogsBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<BlogsController>(BlogsController());
  }

}