import 'package:hive/hive.dart';

part 'session_note.g.dart';

@HiveType(typeId: 1)
class SessionNote extends HiveObject {
  @HiveField(0)
  int trainingId;

  @HiveField(1)
  int sessionId;

  @HiveField(2)
  String noteText;

  @HiveField(3)
  DateTime createdAt;

  SessionNote({
    required this.trainingId,
    required this.sessionId,
    required this.noteText,
    required this.createdAt,
  });
}
