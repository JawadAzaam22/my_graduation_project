import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/my_notes/session_note.dart';
import '../Models/notification_model.dart';

class HiveService {
  static Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    Hive.registerAdapter(AppNotificationAdapter());
    var box = await Hive.openBox<AppNotification>('notifications');
    await box.clear();

    Hive.registerAdapter(SessionNoteAdapter());
    await Hive.openBox<SessionNote>('sessionNotesBox');



  }
}
