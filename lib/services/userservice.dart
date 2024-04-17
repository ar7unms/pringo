import 'dart:convert';

import 'package:http/http.dart' as http;

class userApiservice{

  Future<dynamic> Sentdata(String name,contactno,emailid,password) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://192.168.211.53:3001/api/member/signup");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "name": name,
      "phonenumber": contactno,
      "emailid": emailid,
      "password": password
    }
    )
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("Failed");
    }
  }

  Future<dynamic> loginApi(String email,String password) async{
    var client =http.Client();
    var url = Uri.parse("http://192.168.211.53:3001/api/member/login");
    var response =await client.post(url,
        headers: <String,String>{
          "Content-Type" :"application/json ; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "emailid": email,
          "password": password,
        })
    );

    if(response.statusCode ==200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Fail to send data");
    }
  }

  Future<dynamic> forgot(String emailid) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://192.168.211.53:3001/api/member/forgotPassword");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "emailid": emailid
    }
    )
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("Failed");
    }
  }

  Future<dynamic> resetpassword(String email,String password,String token) async{
    var client =http.Client();
    var url = Uri.parse("http://192.168.211.53:3001/api/member/resetPassword");
    var response =await client.post(url,
        headers: <String,String>{
          "Content-Type" :"application/json ; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "emailid": email,
          "newPassword": password,
          "token":token
        })
    );

    if(response.statusCode ==200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Fail to send data");
    }
  }
}