import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pringooo/models/demomodel.dart';
import 'package:pringooo/models/demomodel2.dart';
import 'dart:io';

import 'package:pringooo/models/uploadmodel.dart';
import 'package:pringooo/pages/adminlogin.dart';
import 'package:pringooo/pages/dailytransaction.dart';
import 'package:pringooo/pages/home.dart';
import 'package:pringooo/services/bindservices.dart';
import 'package:pringooo/services/uploadservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bindhistory extends StatefulWidget {
  @override
  _bindhistoryState createState() => _bindhistoryState();
}

class _bindhistoryState extends State<bindhistory> {
  late Future<List<Demoo>>? data;
  final String fpath = "";

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString("userid") ?? "";
    setState(() {
      data = BindService().getPrintHistory(userId);
    });
  }

  Future<void> downloadFile(String docPath) async {
    try {
      var response = await http.get(Uri.parse('http://192.168.178.53:3001/uploads/$docPath'));
      if (response.statusCode == 200) {
        String? contentType = response.headers['content-type'];

        if (contentType != null && contentType.contains('application/pdf')) {
          final directory = await getExternalStorageDirectory();

          if (directory != null) {
            final filePath = '${directory.path}/$docPath';
            final file = File(filePath);

            await file.writeAsBytes(response.bodyBytes);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('File downloaded successfully')),
            );
          } else {
            print('Error: Directory is null');
          }
        } else {
          print('Error: Invalid content type');
        }
      } else {
        print('Error: Failed to download file, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to upload screen
        },
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {},
                ),
                Text(
                  'HISTORY OF BINDS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 90,
                  width: 125.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.filter_list),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.menu, color: Colors.white),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Sign out',
                            child: Text("SIGN OUT"),
                          ),
                          PopupMenuItem<String>(
                              value: 'Todays Transaction', child: Text("Todays Transaction"))
                        ],
                        onSelected: (String value) {
                          switch (value) {
                            case 'Sign out':
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Do you wanna signout ?'),
                                    content: Text('SIGN OUT ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => adminlogin()));
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              break;
                            case 'Todays Transaction':
                              Navigator.push(context, MaterialPageRoute(builder: (context) => todaytransPage()));
                              break;
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 400,
                    child: ElevatedButton(onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage()));
                    },
                      child: Text("HOME PAGE"),),
                  ),
                  SizedBox(width: 10.0),

                ],
              ),
            ),
            SizedBox(height: 25.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(75.0),
                    topRight: Radius.circular(75.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: data != null ? FutureBuilder(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "COLOR:" + snapshot.data![index].color.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "NO OF BIND:" + snapshot.data![index].noofbind.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "TYPE:" + snapshot.data![index].type.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 19,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  snapshot.data![index].datetime.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    downloadFile(snapshot.data![index].docpath.toString());
                                  },
                                  icon: Icon(Icons.download),
                                  tooltip: 'Download',
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Text('No data available'));
                      }
                    },
                  ) : Container(), // Provide a fallback container if data is null
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
