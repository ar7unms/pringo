// To parse this JSON data, do
//
//     final demoo = demooFromJson(jsonString);

import 'dart:convert';

List<Demoo> demooFromJson(String str) => List<Demoo>.from(json.decode(str).map((x) => Demoo.fromJson(x)));

String demooToJson(List<Demoo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Demoo {
  int id;
  int userid;
  int nofpage;
  String type;
  String color;
  String docpath;
  int noofbind;
  int status;
  int notify;
  DateTime datetime;

  Demoo({
    required this.id,
    required this.userid,
    required this.nofpage,
    required this.type,
    required this.color,
    required this.docpath,
    required this.noofbind,
    required this.status,
    required this.notify,
    required this.datetime,
  });

  factory Demoo.fromJson(Map<String, dynamic> json) => Demoo(
    id: json["id"],
    userid: json["userid"],
    nofpage: json["nofpage"],
    type: json["type"],
    color: json["color"],
    docpath: json["docpath"],
    noofbind: json["noofbind"],
    status: json["status"],
    notify: json["notify"],
    datetime: DateTime.parse(json["datetime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "nofpage": nofpage,
    "type": type,
    "color": color,
    "docpath": docpath,
    "noofbind": noofbind,
    "status": status,
    "notify": notify,
    "datetime": datetime.toIso8601String(),
  };
}
