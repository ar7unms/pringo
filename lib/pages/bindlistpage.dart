import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pringooo/models/bindmodel.dart';
import 'package:pringooo/pages/adminlogin.dart';
import 'package:pringooo/pages/dailytransaction.dart';
import 'package:pringooo/services/bindservices.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class BindListPage extends StatefulWidget {
  const BindListPage({Key? key}) : super(key: key);

  @override
  State<BindListPage> createState() => _BindListPageState();
}

class _BindListPageState extends State<BindListPage> {
  late Future<List<Bind>> data;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    setState(() {
      data = BindService().getalluser();
    });
  }

  Future<void> downloadFile(String docPath) async {
    try {
      var response = await http.get(Uri.parse('http://192.168.211.53:3001/uploads/$docPath'));

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
                  onPressed: () {
                  },
                ),
                Text(
                  'BINDS ORDERS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 30),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.menu,color: Colors.white,),
                      itemBuilder:(BuildContext context)=><PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value:'Sign out',
                          child: Text("SIGN OUT"),
                        ),
                        PopupMenuItem<String>(
                            value: 'Todays Transaction',
                            child: Text("Todays Transaction"))
                      ],
                      onSelected: (String value){
                        switch(value){
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>adminlogin()));
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          case 'Todays Transaction':
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>todaytransPage()));
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  hintText: 'Search by name or type',
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "NAME:"+transactionData[index].name.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "TYPE:"+transactionData[index].type.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "COLOR:"+transactionData[index].color.toString(),
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      children: [
                                        SizedBox(height: 20,),
                                        IconButton(
                                          onPressed: () async{
                                            final response=await BindService().notify(transactionData[index].id.toString());
                                            if(response['status']=="status updated")
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Notification send')),
                                              );
                                            }
                                            final response1=await BindService().notifyuser(transactionData[index].id.toString());
                                          },
                                          icon: Icon(Icons.notifications),
                                          tooltip:'Notify',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  transactionData[index].datetime.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                trailing: IconButton(
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
