import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import '../../../Constants/base_url.dart';
import '../../../Services/service.dart';
import 'agora_rtm_controller.dart';
import 'package:dio/dio.dart' as dio;

class AgoraRtcController extends GetxController {
  final AgoraRtmController rtmController = Get.find<AgoraRtmController>();
  //final AgoraRtmController rtmController = AgoraRtmController();
  bool askedPermission = true;
  bool permissionGranted = true;
  late String trainerId;
  static String appId = "0a26aa0bd0404dfa92f145d64f0a56f3";

  late var token;

  late var channel;
  late var sessionId;
  late var trainingId;
  @override
  void onInit() async {
    trainerId = Get.arguments["trainerId"];
    channel = Get.arguments["chanel"];
    sessionId = Get.arguments["sessionId"];
    trainingId = Get.arguments["training"];
    service = Get.find<UserService>();
    await getToken();
    await _startVideoCalling();
    super.onInit();

    await rtmController.initialize(appId, 'studentId', channel, token);

    rtmController.rtmClient.addListener(
      message: (MessageEvent event) async {
        final peer = event.publisher;
        final msg = utf8.decode(event.message!);

        if (peer == trainerId && msg == 'ACCEPTED') {
          permissionGranted = true;
          isMuted.value = false;
          await engine.muteLocalAudioStream(false);

          showDialog(
            context: Get.context!,
            builder: (_) => AlertDialog(
              title: Text('تم'),
              content: Text('يمكنك التحدث الآن'),
              actions: [
                TextButton(
                    onPressed: () {}
                    //Navigator.pop(context)
                    ,
                    child: Text('حسناً'))
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> getToken() async {
    dio.Dio d = dio.Dio();

    try {
      dio.Response r = await d.get(
        "$baseURL/api/v1/agora/token/channel/$channel",
        options: dio.Options(
          headers: {
            "Authorization": "Bearer ${service.token}",
          },
        ),
      );

      if (r.data["status"] == "success") {
        token = r.data["data"];
      } else {
        Get.snackbar("Error", r.data["message"] ?? "error");
      }
    } on dio.DioException catch (e) {
      Get.snackbar("Error", e.response?.data["message"] ?? e.message);
    }
  }

  late final UserService service;

  int? _remoteUid;
  int? get remoteUid => _remoteUid;
  bool get localUserJoined => _localUserJoined.value;
  final RxBool _localUserJoined = RxBool(false);
  final RxBool _RemoteCameraOpen = RxBool(false);
  bool get RemoteCameraOpen => _RemoteCameraOpen.value;
  final RxBool _remoteUserJoined = RxBool(false);
  bool get remoteUserJoined => _remoteUserJoined.value;
  late RtcEngine engine;
  Future<void> _startVideoCalling() async {
    await _requestPermissions();

    await _initializeAgoraVideoSDK();

    await _setupLocalVideo();

    _setupEventHandlers();
    await _joinChannel();
  }

  // Requests microphone and camera permissions
  Future<void> _requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  // Set up the Agora RTC engine instance
  Future<void> _initializeAgoraVideoSDK() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
  }

  // Enables and starts local video preview
  Future<void> _setupLocalVideo() async {
    await engine.enableVideo();
    await engine.startPreview();
  }

  // Register an event handler for Agora RTC
  void _setupEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          _localUserJoined.value = true;
          update();
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          _remoteUid = remoteUid;
          _remoteUserJoined.value = true;
          update();
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left");
          _remoteUid = null;
          update();
        },
        onUserMuteVideo: (connection, remoteUid, muted) {
          debugPrint("Remote user $remoteUid muted video: $muted");

          if (muted) {
            _RemoteCameraOpen.value = false;
          } else {
            _RemoteCameraOpen.value = true;
          }
          update();
        },
      ),
    );
  }

  // Join a channel
  Future<void> _joinChannel() async {
    await engine.joinChannel(
      token: token,
      channelId: channel,
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true,
        autoSubscribeAudio: true,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: 0,
    );
    await engine.muteLocalAudioStream(true);
  }

  final isMuted = false.obs;
  final isCameraOff = false.obs;
  void toggleCamera() async {
    isCameraOff.value = !isCameraOff.value;

    if (isCameraOff.value) {
      await engine.muteLocalVideoStream(true);
    } else {
      await engine.enableVideo();
      await engine.muteLocalVideoStream(false);
      await engine.startPreview();
    }
  }

  Future<void> leaveChannel() async {
    await engine.leaveChannel();
    await engine.release();
  }

  Future<void> raiseHand() async {
    if (!askedPermission) {
      await rtmController.sendMessageToPeer(trainerId, 'RAISE_HAND');
      askedPermission = true;
      update;
    }
  }

  void toggleMute() {
    if (!askedPermission) {
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          title: Text('تنبيه'),
          content: Text('عليك طلب الإذن أولاً قبل فتح المايكروفون.'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('حسناً'))
          ],
        ),
      );
      return;
    }
    if (!permissionGranted) {
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          title: Text('تنبيه'),
          content: Text('انتظر موافقة المدرب.'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('حسناً'))
          ],
        ),
      );
      return;
    }

    isMuted.value = !isMuted.value;
    engine.muteLocalAudioStream(isMuted.value);
  }

  @override
  void dispose() {
    _cleanupAgoraEngine();
    super.dispose();
  }

  // Leaves the channel and releases resources
  Future<void> _cleanupAgoraEngine() async {
    await engine.leaveChannel();
    await engine.release();
  }
}
