class TraineeModel {
  String? firstName;
  String? lastName;
  String? country;
  String? address;
  String? phoneNumber;
  String? gender;
  int? id;
  String? dateOfBirth;
  String? email;
  String? accessToken;

  TraineeModel({this.firstName,
    this.lastName,
    this.country,
    this.address,
    this.phoneNumber,
    this.gender,
    this.id,
    this.dateOfBirth,
    this.email,
    this.accessToken});

  TraineeModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    country = json['country'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    id = json['id'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country'] = this.country;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['date_of_birth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['access_token'] = this.accessToken;
    return data;
  }
}