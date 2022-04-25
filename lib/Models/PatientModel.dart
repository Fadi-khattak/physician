// To parse this JSON data, do
//
//     final patientModel = patientModelFromJson(jsonString);

import 'dart:convert';

PatientModel patientModelFromJson(String str) =>
    PatientModel.fromJson(json.decode(str));

String patientModelToJson(PatientModel data) => json.encode(data.toJson());

class PatientModel {
  PatientModel({
    required this.name,
    required this.history,
    required this.id,
    required this.pic,
    required this.status,
  });

  String name;
  Map<String, History>? history;
  String id;
  String pic;
  int status;

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        name: json["name"],
        history: Map.from(json["history"] ??
                {
                  "sjkdfghuiovvdbru": {
                    "date": "",
                    "psc": "",
                    "pid": ""
                  }
                })
            .map((k, v) => MapEntry<String, History>(k, History.fromJson(v))),
        id: json["id"],
        pic: json["pic"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "history": Map.from(history!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "id": id,
        "pic": pic,
        "status": status,
      };
}

class History {
  History({
    required this.date,
    required this.psc,
    required this.pid,
  });

  String date;
  String psc;
  String pid;

  factory History.fromJson(Map<String, dynamic> json) => History(
        date: json["date"],
        psc: json["psc"],
        pid: json["pid"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "psc": psc,
        "pid": pid,
      };
}
