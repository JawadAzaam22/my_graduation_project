import 'package:german_board/Controller/profile/search_certificate_controller.dart';
import 'package:get/get.dart';

class SearchCertificateBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<SearchCertificateController>(SearchCertificateController());


  }

}