import 'dart:developer';
import 'dart:io';

class UserModel {
  int? id;
  String? username;
  String? numberPhone;
  String? email;
  String? dateNaissance;
  String? uid;
  File? imagePath;

  UserModel(
      {this.id,
      this.username,
      this.numberPhone,
      this.email,
      this.dateNaissance,
      this.imagePath,
      this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    numberPhone = json['numberPhone'];
    email = json['email'];
    dateNaissance = json['dateNaissance'];
    imagePath = json['imagePath'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    log("ffff");
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['numberPhone'] = numberPhone;
    data['email'] = email;
    data['dateNaissance'] = dateNaissance;
    data['imagePath'] = imagePath;
    data['uid'] = uid;
    return data;
  }
}
