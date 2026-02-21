import 'package:german_board/Models/one_course.dart';
import 'package:get/get.dart';

import '../Services/service.dart';

class BrowseItemController extends GetxController {
  @override
  void onInit() {
    service = Get.find<UserService>();
    courses.assignAll(Get.arguments["courses"] as List<OneCourse>);
    print("object");
    super.onInit();
  }

  RxList<OneCourse> courses = <OneCourse>[].obs;


  final RxBool _isLoading = RxBool(false);
  late final UserService service;
  bool get isLoading => _isLoading.value;


  void navToViewCourse(String type,int id){
    if(type=="recorded"){
      Get.toNamed("/viewRecordedCourse",arguments: {
        "id":id,
      });

    }
    if(type=="live"){
      Get.toNamed("/view",arguments: {
        "id":id,
      });
    }
    if(type=="onsite"){

      Get.toNamed("/viewOnSiteCourse",arguments: {
        "id":id,
      });
   }

  }

}