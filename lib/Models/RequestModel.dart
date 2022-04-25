// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  RequestModel({
    required this.reason,
    required this.name,
    required this.id,
    required this.pic,
  });

  String reason;
  String name;
  String id;
  String pic;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
    reason: json["reason"],
    name: json["name"],
    id: json["id"],
    pic: json["pic"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "name": name,
    "id": id,
    "pic": pic,
  };
}
