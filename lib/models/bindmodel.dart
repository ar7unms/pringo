// To parse this JSON data, do
//
//     final bind = bindFromJson(jsonString);

import 'dart:convert';

List<Bind> bindFromJson(String str) => List<Bind>.from(json.decode(str).map((x) => Bind.fromJson(x)));

String bindToJson(List<Bind> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bind {
  int id;
  int userid;
  int nofpage;
  String type;
  String color;
  String docpath;
  int noofbind;
  DateTime datetime;
  int status;
  String name;

  Bind({
    required this.id,
    required this.userid,
    required this.nofpage,
    required this.type,
    required this.color,
    required this.docpath,
    required this.noofbind,
    required this.datetime,
    required this.status,
    required this.name,
  });

  factory Bind.fromJson(Map<String, dynamic> json) => Bind(
    id: json["id"],
    userid: json["userid"],
    nofpage: json["nofpage"],
    type: json["type"],
    color: json["color"],
    docpath: json["docpath"],
    noofbind: json["noofbind"],
    datetime: DateTime.parse(json["datetime"]),
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "nofpage": nofpage,
    "type": type,
    "color": color,
    "docpath": docpath,
    "noofbind": noofbind,
    "datetime": datetime.toIso8601String(),
    "status": status,
    "name": name,
  };
}
