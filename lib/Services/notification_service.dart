import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/notifications_controller.dart';
import '../Models/notification_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Notifiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
    // تهيئة Hive
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AppNotificationAdapter());
    }
    final box = await Hive.openBox<AppNotification>('notifications');
    final appNotification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      timestamp: DateTime.now(),
      isRead: false,
    );
    print("111111111111111111111111111111111111111111111111");
    await box.add(appNotification);
    print("2222222222222222222222222222222222222222222");
  }

  static Future<void> init() async {
    // 1. Firebase//////////

    //1 fcm token//////////
    String? token = await FirebaseMessaging.instance.getToken();
    print("/////////////////////////////////////////////////////");
    print(token);
    print("/////////////////////////////////////////////////////");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', token!);

    FirebaseMessaging.onMessage.listen(handleForeground);

    // 2. الخلفية//////////
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 3. إذن الإشعارات//////////
    await FirebaseMessaging.instance.requestPermission();

    // 4. Flutter Local Notification init//////////
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // استقبال الإشعار في foreground//////////
  static Future<void> handleForeground(RemoteMessage message) async {
    print("yeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeesssssssssssssssss");
    final box = Hive.box<AppNotification>('notifications');
    final appNotification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      timestamp: DateTime.now(),
      isRead: false,
    );
    print(message);
    print("111111111111111111111111111111111111111111111111");
    await box.add(appNotification);

    print("2222222222222222222222222222222222222222222");
    final controller = Get.isRegistered<NotificationController>()
        ? Get.find<NotificationController>()
        : null;
    controller
        ?.loadNotifications();

    // إشعار محلي//////////
    if (message.notification != null) {
      const androidDetails = AndroidNotificationDetails(
        'channel_id',
        'Notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );
      flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        message.notification!.title,
        message.notification!.body,
        const NotificationDetails(android: androidDetails),
      );
    }
  }
}
