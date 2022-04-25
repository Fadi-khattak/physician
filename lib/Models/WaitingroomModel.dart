// To parse this JSON data, do
//
//     final waitingroomModel = waitingroomModelFromJson(jsonString);

import 'dart:convert';

WaitingroomModel waitingroomModelFromJson(String str) => WaitingroomModel.fromJson(json.decode(str));

String waitingroomModelToJson(WaitingroomModel data) => json.encode(data.toJson());

class WaitingroomModel {
  WaitingroomModel({
    required this.key,
    required this.date,
    required this.time,
    required  this.patient,
    required this.physician,
  });

  String key;
  DateTime date;
  String time;
  Patient patient;
  Physician physician;

  factory WaitingroomModel.fromJson(Map<String, dynamic> json) => WaitingroomModel(
    key: json["key"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    patient: Patient.fromJson(json["patient"]),
    physician: Physician.fromJson(json["physician"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "patient": patient.toJson(),
    "physician": physician.toJson(),
  };
}

class Patient {
  Patient({
    required this.name,
    required  this.id,
    required this.pic,
  });

  String name;
  String id;
  String pic;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    name: json["name"],
    id: json["id"],
    pic: json["pic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "pic": pic,
  };
}

class Physician {
  Physician({
    required this.name,
    required this.id,
    required  this.pic,
    required this.status,
    required this.timming,
  });

  String name;
  String id;
  String pic;
  int status;
  Timming timming;

  factory Physician.fromJson(Map<String, dynamic> json) => Physician(
    name: json["name"],
    id: json["id"],
    pic: json["pic"],
    status: json["status"],
    timming: Timming.fromJson(json["timming"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "pic": pic,
    "status": status,
    "timming": timming.toJson(),
  };
}

class Timming {
  Timming({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.g,
  });

  A a;
  A b;
  A c;
  A d;
  A e;
  A f;
  A g;

  factory Timming.fromJson(Map<String, dynamic> json) => Timming(
    a: A.fromJson(json["a"]),
    b: A.fromJson(json["b"]),
    c: A.fromJson(json["c"]),
    d: A.fromJson(json["d"]),
    e: A.fromJson(json["e"]),
    f: A.fromJson(json["f"]),
    g: A.fromJson(json["g"]),
  );

  Map<String, dynamic> toJson() => {
    "a": a.toJson(),
    "b": b.toJson(),
    "c": c.toJson(),
    "d": d.toJson(),
    "e": e.toJson(),
    "f": f.toJson(),
    "g": g.toJson(),
  };
}

class A {
  A({
    required this.time,
    required this.day,
  });

  String time;
  String day;

  factory A.fromJson(Map<String, dynamic> json) => A(
    time: json["time"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "day": day,
  };
}
