import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pringooo/models/bindmodel.dart';

import 'package:pringooo/models/uploadmodel.dart';
import 'package:pringooo/pages/home.dart';
import 'package:pringooo/services/bindservices.dart';
import 'package:pringooo/services/uploadservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bindnotify extends StatefulWidget {
  @override
  _bindnotifyState createState() => _bindnotifyState();
}

class _bindnotifyState extends State<bindnotify> {
  late Future<List<Bind>>? data = null;


  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userid = preferences.getString("userid") ?? "";
    setState(() {
      data = BindService().viewnotify(userid);
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
                  'Bind notify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
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
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {},
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
                  child: FutureBuilder(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        List<Bind> transactionData = snapshot.data as List<Bind>;

                        return ListView.builder(
                          itemCount: transactionData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start, // Align text at the top
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "COLOR: ${transactionData[index].color}",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "NO OF BIND: ${transactionData[index].noofbind}",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "TYPE: ${transactionData[index].type}",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10), // Add space between columns
                                    Column(
                                      children: [
                                        SizedBox(height: 20),
                                        IconButton( // Use IconButton for Notify button
                                          onPressed: () async {
                                            final response = await ApiService().notify(transactionData[index].id.toString());
                                            if (response['status'] == "status updated") {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Notification sent')),
                                              );
                                            }
                                            final response1 = await BindService().notifyadmin(transactionData[index].id.toString());
                                          },
                                          icon: Icon(Icons.done_all),
                                          tooltip: 'Notify',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(transactionData[index].datetime.toString())),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                trailing: IconButton( // Use IconButton for Download button
                                  onPressed: () {
                                    downloadFile(transactionData[index].docpath.toString());
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
