import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pringooo/models/transactionModel.dart';

class transactionApi {

  Future<dynamic> pay(String userid, String type,String amount) async {
    var client = http.Client();
    var url = Uri.parse("http://192.168.178.53:3001/api/transaction/pay");
    var response = await client.post(url,
        headers: <String, String>{
          "Content-Type": "application/json ; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "userid": userid,
          "type": type,
          "amount": amount,
        })
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception("Fail to send data");
    }
  }


  Future<dynamic> calcamount(String color,String noofpage,String noofcopy) async {
  var client = http.Client();
  var apiUri = Uri.parse("http://192.168.178.53:3001/api/transaction/calcamount");
  var response = await client.post(apiUri,
  headers: <String, String>{
  "Content-Type": "application/json; charset=UTF-8"
  },
  body: jsonEncode(<String, String>{"color": color, "nofpage": noofpage,"noofcopy":noofcopy}));

  if (response.statusCode == 200) {
  var resp = response.body;
  return jsonDecode(resp);
  } else {
  throw Exception("Failed to get amount ");
  }
  }

  Future<dynamic> calamount(String color,String noofpage,String noofbind,String type) async {
    var client = http.Client();
    var apiUri = Uri.parse("http://192.168.178.53:3001/api/transaction/calamount");
    var response = await client.post(apiUri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{"color": color, "nofpage": noofpage,"noofbind":noofbind,"type":type}));

    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    } else {
      throw Exception("Failed to get amount ");
    }
  }


  Future<List<Update>> gettransacyionApi(String userid) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://192.168.178.53:3001/api/transaction/search");
    var response = await client.post(apiUrl,
    headers: <String,String>{
      "Content-Type": "application/json; charset=UTF-8"
    },
    body: jsonEncode(<String,String>{"userid":userid})
    );
    if (response.statusCode == 200) {
      return updateFromJson(response.body);
    }
    else {
      return [];
    }
  }

  Future<dynamic> toadytotal() async {
    var client = http.Client();
    var apiUri = Uri.parse("http://192.168.178.53:3001/api/transaction/todayscollection");
    var response = await client.post(apiUri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        }
       );

    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    } else {
      throw Exception("Failed to get amount ");
    }
  }

  Future<dynamic> toadybindtotal() async {
    var client = http.Client();
    var apiUri = Uri.parse("http://192.168.178.53:3001/api/transaction/todaysbindcollection");
    var response = await client.post(apiUri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        }
    );

    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    } else {
      throw Exception("Failed to get amount ");
    }
  }

  Future<dynamic> toadyprinttotal() async {
    var client = http.Client();
    var apiUri = Uri.parse("http://192.168.178.53:3001/api/transaction/todaysprintcollection");
    var response = await client.post(apiUri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        }
    );

    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    } else {
      throw Exception("Failed to get amount ");
    }
  }


  Future<List<Update>> toadytrans() async {
    var client = http.Client();
    var apiUri = Uri.parse("http://192.168.178.53:3001/api/transaction/todayscollections");
    var response = await client.post(apiUri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        }
    );

    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(response.body) as Future<List<Update>>;
    } else {
      throw Exception("Failed to get amount ");
    }
  }

}