class RecordedTraining {
  int? id;
  String? title;
  String? about;
  String? price;
  String? type;
  int? providerId;
  int? rate;
  int? numberOfRates;
  String? cover;
  List<Tags>? tags;
  String? language;
  List<KeyLearningObjectives>? keyLearningObjectives;
  Provider? provider;
  List<Category>? categories;
  List<Video>? videos;

  RecordedTraining({this.id, this.title, this.about, this.price, this.type, this.providerId, this.rate, this.numberOfRates, this.cover, this.tags, this.language, this.keyLearningObjectives, this.provider, this.categories, this.videos});

  RecordedTraining.fromJson(Map<String, dynamic> json) {
    id = _parseInt(json['id']);
    title = json['title'];
    about = json['about'];
    price = json['price']?.toString();
    type = json['type'];
    providerId = _parseInt(json['provider_id']);
    rate = _parseInt(json['rate']);
    numberOfRates = _parseInt(json['number_of_rates']);
    cover = json['image'];
    if (json['tags'] != null) {
      tags = List<Tags>.from(json['tags'].map((x) => Tags.fromJson(x)));
    }
    language = json['language'];
    if (json['key_learning_objectives'] != null) {
      keyLearningObjectives = List<KeyLearningObjectives>.from(json['key_learning_objectives'].map((x) => KeyLearningObjectives.fromJson(x)));
    }
    provider = json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    if (json['categories'] != null) {
      categories = List<Category>.from(json['categories'].map((x) => Category.fromJson(x)));
    }
    if (json['items'] != null) {
      videos = List<Video>.from(json['items'].map((x) => Video.fromJson(x)));
    }
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
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
}

class KeyLearningObjectives {
  int? id;
  String? text;

  KeyLearningObjectives({this.id, this.text});

  KeyLearningObjectives.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }
}

class Provider {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? brief;
  String? specializedAt;
  String? photo;
  String? cover;

  Provider({this.id, this.firstName, this.lastName, this.phoneNumber, this.dateOfBirth, this.gender, this.brief, this.specializedAt, this.photo, this.cover});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Video {
  int? id;
  String? title;
  String? description;
  String? duration;

  Video({this.id, this.title, this.description, this.duration});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
  }
}
