// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/configuration/back_end.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data);

class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
  });

  String? uid;
  String? name;
  String? email;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "name": name,
        "email": email,
        "password": password,
      };
}
