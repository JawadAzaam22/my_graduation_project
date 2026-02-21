class Provider {
  final int? id;
  final int? userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String brief;
  final String specializedAt;
  final String photo;
  final String cover;
  final String createdAt;
  final String updatedAt;
  final int isCompleteProfile;

  Provider({
    this.id,
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.brief,
    required this.specializedAt,
    required this.photo,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleteProfile,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      userId: json['user_id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      brief: json['brief'] ?? '',
      specializedAt: json['specialized_at'] ?? '',
      photo: json['photo'] ?? '',
      cover: json['cover'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isCompleteProfile: json['is_complete_profile'] ?? 0,
    );
  }
}

class OneCourse {
  final int? id;
  final String name;
  final String cover;
  final double rating;
  final String price;
  final String type;
  final Provider? provider;

  OneCourse({
    this.id,
    required this.name,
    required this.cover,
    required this.rating,
    required this.price,
    required this.type,
    this.provider,
  });

  factory OneCourse.fromJson(Map<String, dynamic> json) {
    return OneCourse(
      id: json['id'],
      name: json['name'] ?? '',
      cover: json['cover'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      price: json['price'] ?? '',
      type: json['type'] ?? '',
      provider: json['provider'] != null ? Provider.fromJson(json['provider']) : null,
    );
  }
}
