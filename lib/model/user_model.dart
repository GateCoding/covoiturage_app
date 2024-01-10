import 'dart:developer';

class UserModel {
  int? id;
  String? username;
  String? numberPhone;
  String? email;
  String? dateNaissance;
  String? uid;

  UserModel(
      {this.id,
      this.username,
      this.numberPhone,
      this.email,
      this.dateNaissance,
      this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    numberPhone = json['numberPhone'];
    email = json['email'];
    dateNaissance = json['dateNaissance'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    log("ffff");
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['numberPhone'] = numberPhone;
    data['email'] = email;
    data['dateNaissance'] = dateNaissance;
    data['uid'] = uid;
    return data;
  }
}
