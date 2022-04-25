// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.id,
    required this.pic,
    required this.status,
  });

  String name;
  String id;
  String pic;
  int status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"],
    id: json["id"],
    pic: json["pic"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "pic": pic,
    "status": status,
  };
}
