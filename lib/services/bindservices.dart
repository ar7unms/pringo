import 'dart:convert';
import 'dart:io';
import 'package:pringooo/models/bindmodel.dart';
import 'package:pringooo/models/uploadmodel.dart';
import 'package:http/http.dart' as http;

class BindService {
  final String baseUrl = "http://192.168.211.53:3001/api/bind"; // Replace with your Node.js server URL

  Future<dynamic> uploadFile(String userid, String nofpage,String type,String noofbind, String color, String filePath, bool i) async {
    try {
      var uri = Uri.parse('$baseUrl/upload');
      var request = http.MultipartRequest('POST', uri);
      request.fields.addAll({
        'userid': userid,
        'nofpage': nofpage,
        'type': type,
        'noofbind': noofbind,
        'color':color,
        'status':i.toString(),
        'notify':i.toString()
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

  Future<List<Bind>> getalluser() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.211.53:3001/api/bind/viewnotupdated");
    var response = await client.post(apiUrl,
      headers: <String,String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
    );
    if (response.statusCode == 200) {
      return bindFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<dynamic> notify(String bindId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/updatestatus'),
        body: {'id': bindId},
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

  Future<dynamic> notifyuser(String bindId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/updatenotify'),
        body: {'id': bindId},
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

  Future<dynamic> notifyadmin(String bindId) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/updatenotif'),
        body: {'id': bindId},
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

  Future<List<Bind>> viewnotify(String userid) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/viewnotify'),
        body: {'userid': userid},
      );

      if (response.statusCode == 200) {
        // Parse the response data into a list of Bind objects
        List<dynamic> responseData = json.decode(response.body);
        List<Bind> bindList = responseData.map((data) => Bind.fromJson(data)).toList();
        return bindList;
      } else {
        throw Exception('Failed to fetch bind notifications');
      }
    } catch (e) {
      print('Error fetching bind notifications: $e');
      throw Exception('Error fetching bind notifications');
    }
  }

}
