// To parse this JSON data, do
//
//     final upload = uploadFromJson(jsonString);

import 'dart:convert';

List<Upload> uploadFromJson(String str) => List<Upload>.from(json.decode(str).map((x) => Upload.fromJson(x)));

String uploadToJson(List<Upload> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Upload {
  int id;
  int userid;
  int start;
  int end;
  int noofcopy;
  String color;
  String docpath;
  DateTime datetime;
  String name;

  Upload({
    required this.id,
    required this.userid,
    required this.start,
    required this.end,
    required this.noofcopy,
    required this.color,
    required this.docpath,
    required this.datetime,
    required this.name,
  });

  factory Upload.fromJson(Map<String, dynamic> json) => Upload(
    id: json["id"],
    userid: json["userid"],
    start: json["start"],
    end: json["end"],
    noofcopy: json["noofcopy"],
    color: json["color"],
    docpath: json["docpath"],
    datetime: DateTime.parse(json["datetime"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "start": start,
    "end": end,
    "noofcopy": noofcopy,
    "color": color,
    "docpath": docpath,
    "datetime": datetime.toIso8601String(),
    "name": name,
  };
}
