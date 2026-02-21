import 'package:german_board/Controller/blogs/view_blog_controller.dart';
import 'package:get/get.dart';

class ViewBlogBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ViewBlogController>(ViewBlogController());
  }

}