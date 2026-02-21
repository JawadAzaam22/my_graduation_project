class HomeTraining {
  List<Trainings>? trainings;
  List<Category>? categories;

  HomeTraining({this.trainings, this.categories});

  HomeTraining.fromJson(Map<String, dynamic> json) {
    if (json['trainings'] != null) {
      trainings = <Trainings>[];
      json['trainings'].forEach((v) {
        trainings!.add(new Trainings.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trainings != null) {
      data['trainings'] = this.trainings!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trainings {
  int? id;
  String? title;
  String? about;
  String? price;
  String? type;
  int? providerId;
  int? categoryId;
  String? language;
  int? rate;
  Category? category;

  Trainings(
      {this.id,
        this.title,
        this.about,
        this.price,
        this.type,
        this.providerId,
        this.categoryId,
        this.language,
        this.rate,
        this.category});

  Trainings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    about = json['about'];
    price = json['price'];
    type = json['type'];
    providerId = json['provider_id'];
    categoryId = json['category_id'];
    language = json['language'];
    rate = json['rate'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['about'] = this.about;
    data['price'] = this.price;
    data['type'] = this.type;
    data['provider_id'] = this.providerId;
    data['category_id'] = this.categoryId;
    data['language'] = this.language;
    data['rate'] = this.rate;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  int? number_of_courses;

  Category({this.id, this.name,this.number_of_courses});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number_of_courses = json['number_of_courses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number_of_courses'] = this.number_of_courses;
    return data;
  }
}