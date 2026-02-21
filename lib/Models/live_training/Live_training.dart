class LiveTraining {
  int? id;
  String? title;
  String? about;
  String? price;
  String? type;
  int? providerId;
  int? rate;
  String? start_date;
  String? end_date;
  String? language;
  int? duration_in_hours;
  int? numberOfRates;
  String? cover;

  List<Tags>? tags;
  List<KeyLearningObjectives>? keyLearningObjectives;
  Provider? provider;
  List<Category>? categories;
  String? training_site;

  LiveTraining({
    this.id,
    this.title,
    this.about,
    this.price,
    this.type,
    this.providerId,
    this.rate,
    this.start_date,
    this.end_date,
    this.language,
    this.duration_in_hours,
    this.numberOfRates,
    this.cover,
    this.tags,
    this.keyLearningObjectives,
    this.provider,
    this.categories,
    this.training_site,
  });

  LiveTraining.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    about = json['about'];
    price = json['price'];
    type = json['type'];
    providerId = json['provider_id'];
    rate = json['rate'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    duration_in_hours = json['duration_in_hours'];
    language = json['language'];
    numberOfRates = json['number_of_rates'];
    cover = json['cover'];

    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }

    if (json['key_learning_objectives'] != null) {
      keyLearningObjectives = [];
      json['key_learning_objectives'].forEach((v) {
        keyLearningObjectives!.add(KeyLearningObjectives.fromJson(v));
      });
    }

    provider = json['provider'] != null
        ? Provider.fromJson(json['provider'])
        : null;

    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    training_site = json['training_site'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['about'] = about;
    data['price'] = price;
    data['type'] = type;
    data['provider_id'] = providerId;
    data['rate'] = rate;
    data['start_date'] = start_date;
    data['end_date'] = end_date;
    data['duration_in_hours'] = duration_in_hours;
    data['language'] = language;
    data['number_of_rates'] = numberOfRates;
    data['cover'] = cover;

    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (keyLearningObjectives != null) {
      data['key_learning_objectives'] =
          keyLearningObjectives!.map((v) => v.toJson()).toList();
    }
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['training_site'] = training_site;

    return data;
  }
}

class Tags {
  int? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class KeyLearningObjectives {
  int? id;
  String? text;

  KeyLearningObjectives({this.id, this.text});

  KeyLearningObjectives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
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

  Provider({
    this.id,
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
  });

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
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'brief': brief,
      'specialized_at': specializedAt,
      'photo': photo,
      'cover': cover,
    };
  }
}
