// To parse this JSON data, do
//
//     final update = updateFromJson(jsonString);

import 'dart:convert';

Update updateFromJson(String str) => Update.fromJson(json.decode(str));

String updateToJson(Update data) => json.encode(data.toJson());

class Update {
  int id;
  String name;
  int phonenumber;
  String emailid;
  String password;

  Update({
    required this.id,
    required this.name,
    required this.phonenumber,
    required this.emailid,
    required this.password,
  });

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    id: json["id"],
    name: json["name"],
    phonenumber: json["phonenumber"],
    emailid: json["emailid"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phonenumber": phonenumber,
    "emailid": emailid,
    "password": password,
  };
}
