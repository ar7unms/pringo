// To parse this JSON data, do
//
//     final demo = demoFromJson(jsonString);

import 'dart:convert';

List<Demo> demoFromJson(String str) => List<Demo>.from(json.decode(str).map((x) => Demo.fromJson(x)));

String demoToJson(List<Demo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Demo {
  int id;
  int userid;
  int start;
  int end;
  int noofcopy;
  String color;
  String docpath;
  int status;
  int notify;
  DateTime datetime;

  Demo({
    required this.id,
    required this.userid,
    required this.start,
    required this.end,
    required this.noofcopy,
    required this.color,
    required this.docpath,
    required this.status,
    required this.notify,
    required this.datetime,
  });

  factory Demo.fromJson(Map<String, dynamic> json) => Demo(
    id: json["id"],
    userid: json["userid"],
    start: json["start"],
    end: json["end"],
    noofcopy: json["noofcopy"],
    color: json["color"],
    docpath: json["docpath"],
    status: json["status"],
    notify: json["notify"],
    datetime: DateTime.parse(json["datetime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "start": start,
    "end": end,
    "noofcopy": noofcopy,
    "color": color,
    "docpath": docpath,
    "status": status,
    "notify": notify,
    "datetime": datetime.toIso8601String(),
  };
}
