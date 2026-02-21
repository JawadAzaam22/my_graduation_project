import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../Models/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <AppNotification>[].obs;

  Box<AppNotification>? _box;

  @override
  void onInit() async {
    super.onInit();
    _box = Hive.box<AppNotification>('notifications');
    // تحميل الإشعارات من Hive
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    await _box?.close();
    _box = await Hive.openBox<AppNotification>('notifications');
    final allNotifs = _box!.values.toList().reversed.toList();
    notifications.assignAll(allNotifs);
    update();
  }

  RxInt get unreadCount => notifications.where((n) => !n.isRead).length.obs;

  Future<void> markAllAsRead() async {
    for (var n in notifications) {
      if (!n.isRead) {
        n.isRead = true;
        await n.save();
      }
    }
    loadNotifications();
  }

  Future<void> addNotification(AppNotification n) async {
    await _box!.add(n);
    loadNotifications();
  }
}
