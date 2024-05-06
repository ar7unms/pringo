import 'dart:convert';
import 'dart:io';
import 'package:pringooo/models/demomodel.dart';
import 'package:pringooo/models/uploadmodel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.168.178.53:3001/api/print"; // Replace with your Node.js server URL

  Future<dynamic> uploadFile(String userid, String start,String end,String noofcopy, String color, String filePath, bool i,bool j) async {
    try {
      var uri = Uri.parse('$baseUrl/upload');
      var request = http.MultipartRequest('POST', uri);
        request.fields.addAll({
          'userid': userid,
          'start': start,
          'end': end,
          'noofcopy': noofcopy,
          'color': color,
          'status':i.toString(),
          'notify':j.toString()
        });
        request.files.add(await http.MultipartFile.fromPath('file',filePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else {
        throw Exception('Failed to upload file');
      }
    } catch (e) {
      print('Error uploading file: $e');
      throw Exception('Error uploading file');
    }
  }

  Future<dynamic> searchUser(String memberId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/search'),
        body: {'id': memberId},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search user');
      }
    } catch (e) {
      print('Error searching user: $e');
      throw Exception('Error searching user');
    }
  }

  Future<List<Upload>> getalluser() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.178.53:3001/api/print/viewnotupdated");
    var response = await client.post(apiUrl,
        headers: <String,String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
    );
    if (response.statusCode == 200) {
      return uploadFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<dynamic> notify(String printId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/updatestatus'),
        body: {'id': printId},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to notify');
      }
    } catch (e) {
      throw Exception('Error notifying');
    }
  }

  Future<dynamic> notifyuser(String printId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/updatenotify'),
        body: {'id': printId},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to notify');
      }
    } catch (e) {
      throw Exception('Error notifying');
    }
  }
  Future<dynamic> notifyadmin(String printId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/updatenotif'),
        body: {'id': printId},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to notify');
      }
    } catch (e) {
      throw Exception('Error notifying');
    }
  }
  Future<List<Demo>> getPrintHistory(String userId) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.178.53:3001/api/print/printhistory'),
        body: {'userid': userId},
      );

      if (response.statusCode == 200) {
        print("///////////"+response.body);
        return demoFromJson(response.body);
      } else {
        throw Exception('Failed to fetch print history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching print history: $e');
      throw Exception('Error fetching print history: $e');
    }
  }


  Future<List<Upload>> viewnotify(String userid) async {

      var response = await http.post(
        Uri.parse('http://192.168.178.53:3001/api/print/viewnotify'),
        body: {'userid': userid},
      );

      if (response.statusCode == 200) {
        // Parse the response data into a list of Bind objects
        List<dynamic> responseData = json.decode(response.body);
        List<Upload> printList = responseData.map((data) => Upload.fromJson(data)).toList();
        return printList;
      } else {
        return [];
      }

  }

}
