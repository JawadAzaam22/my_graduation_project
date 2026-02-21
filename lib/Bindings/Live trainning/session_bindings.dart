import 'package:get/get.dart';

import '../../Controller/Live training/agora/agora_rtc_controller.dart';
import '../../Controller/Live training/agora/agora_rtm_controller.dart';

class SessionBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<AgoraRtmController>(AgoraRtmController());
    Get.put<AgoraRtcController>(AgoraRtcController());

  }

}