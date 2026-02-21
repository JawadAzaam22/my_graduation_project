import 'dart:convert';
import 'package:agora_rtm/agora_rtm.dart';

class AgoraRtmController {
  late RtmClient rtmClient;

  Future<void> initialize(
      String appId, String userId, String channel, String token) async {
    final (status, client) = await RTM(appId, userId);
    if (status.error == true) {
      print('Failed to initialize RTM: ${status.reason}');
      return;
    }
    rtmClient = client;
    await rtmClient.login(
        "007eJxSYGC+4h62ptV52WGZ13mRM/zXvBRqXca16O+lqocfyy8s3s+iwGCeYmmQmpqWmpqWZmCSkpqaaGyZaJRmYWqRYmKYZmZp6mGZmXFAnZMhYt0UFiYGRgYQBvFZoGRJanEJJ0NxSWlKal6JZwpIGqIASRAQAAD//0o6KyM=");
    await rtmClient.subscribe(channel);
  }

  Future<void> sendMessageToPeer(String peerId, String message) async {
    await rtmClient.publishBinaryMessage(peerId, utf8.encode(message),
        channelType: RtmChannelType.user);
  }

  Future<void> leaveChannel(String channel) async {
    await rtmClient.unsubscribe(channel);
  }

  Future<void> logout() async {
    await rtmClient.logout();
  }
}
