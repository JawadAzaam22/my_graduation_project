import 'package:german_board/Controller/profile/setting_notification_controller.dart';
import 'package:get/get.dart';

import '../../Controller/profile/my_profile_controller.dart';
import '../../Controller/profile/security_controller.dart';


class SettingNotificationBindings implements Bindings{

  @override
  void dependencies() {
    Get.put<SettingNotificationController>(SettingNotificationController());


  }

}