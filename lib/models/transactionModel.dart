// To parse this JSON data, do
//
//     final update = updateFromJson(jsonString);

import 'dart:convert';

List<Update> updateFromJson(String str) => List<Update>.from(json.decode(str).map((x) => Update.fromJson(x)));

String updateToJson(List<Update> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Update {
  int tranid;
  int userid;
  String type;
  int amount;
  DateTime datetime;
  String name;

  Update({
    required this.tranid,
    required this.userid,
    required this.type,
    required this.amount,
    required this.datetime,
    required this.name,
  });

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    tranid: json["tranid"],
    userid: json["userid"],
    type: json["type"],
    amount: json["amount"],
    datetime: DateTime.parse(json["datetime"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "tranid": tranid,
    "userid": userid,
    "type":type,
    "amount": amount,
    "datetime": datetime.toIso8601String(),
    "name": name,
  };
}
