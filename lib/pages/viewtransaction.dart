
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pringooo/models/transactionModel.dart';
import 'package:pringooo/pages/home.dart';
import 'package:pringooo/pages/uploadingscreen.dart';
import 'package:pringooo/services/transactionService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewTransactionPage extends StatefulWidget {
  const ViewTransactionPage({Key? key});

  @override
  State<ViewTransactionPage> createState() => _ViewTransactionPageState();
}

class _ViewTransactionPageState extends State<ViewTransactionPage> {
  late Future<List<Update>> data;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString("userid") ?? "";
    setState(() {
      data = transactionApi().gettransacyionApi(userId);
    });
  }
  TextEditingController n1= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => uploadScreen1()));
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
            Padding(
              padding: EdgeInsets.only(top: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  Text(
                    'Transactions',
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
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Expanded(
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
                  SizedBox(width: 10.0),
                ],
              ),
            ),

            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 40.0),
            ),
            SizedBox(height: 40.0),
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
                  padding: const EdgeInsets.all(10.0),
                  child: FutureBuilder(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        List<Update> transactionData = snapshot.data as List<Update>;

                        return Container(
                          child: ListView.builder(
                            itemCount: transactionData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                color: Colors.white.withOpacity(0.9),
                                child: ListTile(
                                  title: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(transactionData[index].name.toString(), style: TextStyle(fontWeight: FontWeight.w900)),
                                            Text(transactionData[index].type.toString(), style: TextStyle(fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Text(transactionData[index].amount.toString(), style: TextStyle(fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          Icon(Icons.currency_rupee),
                                        ],
                                      )
                                    ],
                                  ),
                                  subtitle: Text(
                                    transactionData[index].datetime.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                          ),
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

class CardTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const CardTextField({
    required this.labelText,
    required this.icon,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                prefixIcon: Icon(icon),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
