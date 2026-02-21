class MyCourses {
  final List<Course> recorded;
  final List<Course> live;

  MyCourses({required this.recorded, required this.live});

  factory MyCourses.fromJson(Map<String, dynamic> json) {
    return MyCourses(
      recorded: (json['data']['recorded'] as List)
          .map((e) => Course.fromJson(e))
          .toList(),
      live: (json['data']['live'] as List)
          .map((e) => Course.fromJson(e))
          .toList(),
    );
  }
}

class Course {
  final int id;
  final String courseTitle;
  final String courseImage;
  final double rating;
  final double durationInHours;
  final String instructorName;
  final String instructorRole;
  final String instructorImage;
  final bool isCompleted;
  final int? hoursRemaining;
  final String? achievementRate;

  Course({
    required this.id,
    required this.courseTitle,
    required this.courseImage,
    required this.rating,
    required this.durationInHours,
    required this.instructorName,
    required this.instructorRole,
    required this.instructorImage,
    required this.isCompleted,
    this.hoursRemaining,
    this.achievementRate,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      courseTitle: json['courseTitle'] ?? '',
      courseImage: json['courseImage'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      durationInHours: (json['duration_in_hours'] ?? 0).toDouble(),
      instructorName: json['instructorName'] ?? '',
      instructorRole: json['instructorRole'] ?? '',
      instructorImage: json['instructorImage'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      hoursRemaining: json['hoursRemaining'],
      achievementRate: json['achievementRate']??"0.00"
    );
  }
}