class Profiles {
  int? id;
  String? name;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? brief;
  String? location;
  String? specializedAt;
  String? photo;
  String? cover;
  String? role;
  List<Training>? trainings;
  int? allTraineeEnrolled;

  Profiles({
    this.id,
    this.name,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.brief,
    this.location,
    this.specializedAt,
    this.photo,
    this.cover,
    this.role,
    this.trainings,
    this.allTraineeEnrolled,
  });

  Profiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    brief = json['brief'];
    location = json['location'];
    specializedAt = json['specialized_at'];
    photo = json['photo'];
    cover = json['cover'];
    role = json['role'];
    if (json['trainings'] != null) {
      trainings = <Training>[];
      json['trainings'].forEach((v) {
        trainings!.add(Training.fromJson(v));
      });
    }
    allTraineeEnrolled = json['all_trainee_enrolled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['brief'] = brief;
    data['location'] = location;
    data['specialized_at'] = specializedAt;
    data['photo'] = photo;
    data['cover'] = cover;
    data['role'] = role;
    if (trainings != null) {
      data['trainings'] = trainings!.map((v) => v.toJson()).toList();
    }
    data['all_trainee_enrolled'] = allTraineeEnrolled;
    return data;
  }
}

class Training {
  int? id;
  String? name;
  String? cover;
  int? rating;
  String? price;
  String? type;
  int? traineeEnrolled;

  Training({
    this.id,
    this.name,
    this.cover,
    this.rating,
    this.price,
    this.type,
    this.traineeEnrolled,
  });

  Training.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    rating = json['rating'] is double ? (json['rating'] as double).toInt() : json['rating'];
    price = json['price'];
    type = json['type'];
    traineeEnrolled = json['trainee_enrolled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cover'] = cover;
    data['rating'] = rating;
    data['price'] = price;
    data['type'] = type;
    data['trainee_enrolled'] = traineeEnrolled;
    return data;
  }
}