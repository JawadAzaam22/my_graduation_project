import 'package:german_board/Controller/notifications_controller.dart';
import 'package:get/get.dart';

import '../Services/service.dart';

class InitialBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<UserService>(UserService());
    Get.put<NotificationController>(NotificationController(),permanent: true);
     //Get.put<SplashController>(SplashController());


  }

}