import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controller/Live training/agora/agora_rtc_controller.dart';
import '../widgets/add_note_dialog.dart';

class SessionScreen extends GetView<AgoraRtcController> {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => Center(
              child: controller.remoteUserJoined
                  ? controller.RemoteCameraOpen
                      ? AgoraVideoView(
                          controller: VideoViewController.remote(
                            rtcEngine: controller.engine,
                            canvas: VideoCanvas(uid: controller.remoteUid),
                            connection:
                                RtcConnection(channelId: controller.channel),
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 80.sp,
                          ),
                        )
                  : const Text(
                      'Waiting for trainer to join...',
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 100,
                height: 150,
                child: Center(
                  child: !controller.localUserJoined
                      ? const CircularProgressIndicator()
                      : !controller.isCameraOff.value
                          ? AgoraVideoView(
                              controller: VideoViewController(
                                rtcEngine: controller.engine,
                                canvas: const VideoCanvas(
                                  uid: 0,
                                  renderMode: RenderModeType.renderModeHidden,
                                ),
                              ),
                            )
                          : Container(child: Icon(Icons.videocam_off)),
                ),
              ),
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  EdgeInsets.only(bottom: 24.h),
                child: Container(
                  padding:
                       EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      _controlButton(
                        icon: controller.isMuted.value
                            ? Icons.mic_off
                            : Icons.mic,
                        color: controller.isMuted.value
                            ? Colors.red
                            : Colors.white,
                        onPressed: () => controller.toggleMute(),
                      ),
                     //  SizedBox(width: 20.w),
                      _controlButton(
                        icon: controller.isCameraOff.value
                            ? Icons.videocam_off
                            : Icons.videocam,
                        color: controller.isCameraOff.value
                            ? Colors.red
                            : Colors.white,
                        onPressed: () => controller.toggleCamera(),
                      ),
                    //   SizedBox(width: 20.w),
                      _controlButton(
                        icon: Icons.call_end,
                        color: Colors.redAccent,
                        onPressed: () {
                          controller.leaveChannel();
                          Get.back();
                        },
                      ),
                  //     SizedBox(width: 20.w),
                      _controlButton(
                          icon: Icons.front_hand,
                          color: Colors.white,
                          onPressed: () => controller.raiseHand()),

                   //    SizedBox(width: 20.w),
                      _controlButton(
                          icon: Icons.note_add_outlined,
                          color: Colors.white,
                          onPressed: () {Get.dialog(AddNoteDialog(sessionId: int.parse(controller.sessionId), trainingId:int.parse(controller.trainingId),));}),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
Widget _controlButton({
  required IconData icon,
  required Color color,
  required VoidCallback onPressed,
}) {
  return CircleAvatar(
    backgroundColor: Colors.white12,
    radius: 28.sp,
    child: IconButton(
      icon: Icon(icon, color: color, size: 28.sp),
      onPressed: onPressed,
    ),
  );
}
