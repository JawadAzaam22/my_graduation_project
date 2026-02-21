
import '../../../Models/live_training/enrolled_live_training_details_model.dart';
class LessonItem {
  final int? videoId;
  final int? quizId;
  final String title;
  final String? videoUrl;
  final String? duration;
  final String type; // "video" or "quiz"
  dynamic status; // bool للفيديو، String للاختبار
  final bool isLocked;

  LessonItem({
    this.videoId,
    this.quizId,
    required this.title,
    this.videoUrl,
    this.duration,
    required this.type,
    required this.status,
    required this.isLocked,
  });

  factory LessonItem.fromJson(Map<String, dynamic> json) {
    dynamic parsedStatus;

    if (json['type'] == 'video') {
      if (json['status'] is bool) {
        parsedStatus = json['status'];
      } else if (json['status'] is String) {
        final statusStr = json['status'].toString().toLowerCase();
        parsedStatus = (statusStr == 'true');
      } else {
        parsedStatus = false;
      }
    } else if (json['type'] == 'quiz') {
      parsedStatus = json['status']?.toString() ?? 'not completed';
    } else {
      parsedStatus = json['status'];
    }

    return LessonItem(
      videoId: json['video_id'],
      quizId: json['quiz_id'],
      title: json['title'],
      videoUrl: json['videoUrl'],
      duration: json['duration'],
      type: json['type'],
      status: parsedStatus,
      isLocked: json['isLocked'] ?? false,
    );
  }
}


class Lesson {
  final int id;
  final String title;
  final String image;
  final List<Attachments> attachments;
  final List<LessonItem> items;
  final String? certificationImage;
  final String? certificationCode;

  Lesson({
    required this.id,
    required this.title,
    required this.image,
    required this.attachments,
    required this.items,
    this.certificationImage,
    this.certificationCode,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    var attachmentsJson = json['attachments'] as List<dynamic>? ?? [];
    var itemsJson = json['items'] as List<dynamic>? ?? [];

    List<Attachments> attachmentsList = attachmentsJson.map((a) => Attachments.fromJson(a)).toList();
    List<LessonItem> itemsList = itemsJson.map((i) => LessonItem.fromJson(i)).toList();

    return Lesson(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      attachments: attachmentsList,
      items: itemsList,
      certificationImage: json['certification_image'],
      certificationCode: json['certification_code'],
    );
  }
}
