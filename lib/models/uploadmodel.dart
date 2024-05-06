import 'dart:convert';

List<Upload> uploadFromJson(String str) {
  try {
    if (str == null) {
      return []; // Return an empty list if the JSON string is null
    }
    final List<dynamic> parsedJson = json.decode(str);
    return parsedJson.map((json) => Upload.fromJson(json)).toList();
  } catch (e) {
    print('Error parsing JSON: $e');
    return []; // Return an empty list or handle the error as needed
  }
}

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
