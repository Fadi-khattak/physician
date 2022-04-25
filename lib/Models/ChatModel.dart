// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    required this.dt,
    required this.msg,
    required this.rid,
    required this.sid,
  });

  String dt;
  String msg;
  String rid;
  String sid;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    dt: json["dt"],
    msg: json["msg"],
    rid: json["rid"],
    sid: json["sid"],
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "msg": msg,
    "rid": rid,
    "sid": sid,
  };
}
