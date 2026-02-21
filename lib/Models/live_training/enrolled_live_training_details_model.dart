class EnrolledLiveTraining {
  int? id;
  String? title;
  String? about;
  String? price;
  String? type;
  int? rate;
  int? numberOfRates;
  Provider? provider;
  List<Sessions>? sessions;
  List<Attachments>? attachments;
  String? cover;

  EnrolledLiveTraining(
      {this.id,
      this.title,
      this.about,
      this.price,
      this.type,
      this.rate,
      this.numberOfRates,
      this.provider,
      this.sessions,
      this.attachments,
      this.cover});

  EnrolledLiveTraining.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    about = json['about'];
    price = json['price'];
    type = json['type'];
    rate = json['rate'];
    numberOfRates = json['number_of_rates'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    if (json['sessions'] != null) {
      sessions = [];
      json['sessions'].forEach((v) {
        sessions!.add(new Sessions.fromJson(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = [];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['about'] = this.about;
    data['price'] = this.price;
    data['type'] = this.type;
    data['rate'] = this.rate;
    data['number_of_rates'] = this.numberOfRates;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.sessions != null) {
      data['sessions'] = this.sessions!.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    data['cover'] = this.cover;
    return data;
  }
}

class Provider {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? brief;
  String? specializedAt;
  String? photo;
  String? cover;
  String? createdAt;
  String? updatedAt;

  Provider(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.dateOfBirth,
      this.gender,
      this.brief,
      this.specializedAt,
      this.photo,
      this.cover,
      this.createdAt,
      this.updatedAt});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    brief = json['brief'];
    specializedAt = json['specialized_at'];
    photo = json['photo'];
    cover = json['cover'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['brief'] = this.brief;
    data['specialized_at'] = this.specializedAt;
    data['photo'] = this.photo;
    data['cover'] = this.cover;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Sessions {
  int? id;
  String? date;
  String? time;
  String? notes;
  String? status;
  String? title;

  Sessions(
      {this.id, this.date, this.time, this.notes, this.status, this.title});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    notes = json['notes'];
    status = json['status'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['notes'] = this.notes;
    data['status'] = this.status;
    data['title'] = this.title;
    return data;
  }
}

class Attachments {
  String? fileUrl;
  String? fileName;
  String? fileSize;
  String? fileDate;

  Attachments({this.fileUrl, this.fileName, this.fileSize, this.fileDate});

  Attachments.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
    fileName = json['file_name'];
    fileSize = json['file_size'];
    fileDate = json['file_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_url'] = this.fileUrl;
    data['file_name'] = this.fileName;
    data['file_size'] = this.fileSize;
    data['file_date'] = this.fileDate;
    return data;
  }
}
