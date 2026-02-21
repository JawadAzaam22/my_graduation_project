import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Controller/notifications_controller.dart';

class AppLifecycleReactor extends StatefulWidget {
  final Widget child;
  const AppLifecycleReactor({required this.child, Key? key}) : super(key: key);

  @override
  State<AppLifecycleReactor> createState() => _AppLifecycleReactorState();
}

class _AppLifecycleReactorState extends State<AppLifecycleReactor>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final notifController = Get.find<NotificationController>();
      print("8888888888888888888888888888888888888888888888888888888");
      await notifController.loadNotifications();
      print("8888888888888888888888888888888888888888888888888888888");
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
