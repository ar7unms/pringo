import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pringooo/models/bindmodel.dart';
import 'package:pringooo/models/transactionModel.dart';
import 'package:pringooo/services/bindservices.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:pringooo/services/transactionService.dart';

class todaytransPage extends StatefulWidget {
  const todaytransPage({Key? key}) : super(key: key);

  @override
  State<todaytransPage> createState() => _todaytransPageState();
}

class _todaytransPageState extends State<todaytransPage> {
  DateFormat timeFormat=DateFormat.Hm();

  @override
  String amount ="0";
  String bindamount ="0";
  String printamount ="0";
  @override
  void initState() {
    super.initState();
    _loadData(); // Call _loadData first

    // Wait for toadytrans to complete before setting data

  }

  _loadData() async {
    final response =await transactionApi().toadytotal();
    setState(() {

      if (response["status"]=="success")
      {
        amount=response["total"].toString();
        print(amount);
        print("success");

      }
    });
    final response1 =await transactionApi().toadybindtotal();
    setState(() {

      if (response1["status"]=="success")
      {
        bindamount=response1["total"].toString();
        print(bindamount);
        print("success");

      }
    });
    final response2 =await transactionApi().toadyprinttotal();
    setState(() {

      if (response2["status"]=="success")
      {
        printamount=response2["total"].toString();
        print(printamount);
        print("success");

      }
    });
  }



  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
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
                    Navigator.pop(context);
                  },
                ),

                SizedBox(width: 30),

              ],
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0,),
              child:   Column(
                children: [
                  Text(
                    'TOTAL TRANSACTION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  child:
                    ListView(scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 50),
                            height: 600,
                            width: 300,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black,blurRadius: 20)],
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              )
                            ),
                            child:
                            Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'TOTAL PRINT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      printamount,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(width: 20,),
                      Container(
                        height: 600,
                        width: 300,
                        padding: EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            boxShadow: [BoxShadow(color: Colors.black,blurRadius: 20)],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            )
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'TOTAL BIND',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  bindamount,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                          SizedBox(width: 20,),
                          Container(
                            height: 600,
                            width: 300,
                            padding: EdgeInsets.only(top: 50),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                boxShadow: [BoxShadow(color: Colors.black,blurRadius: 20)],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                )
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.only(top:200),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'TOTAL AMOUNT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      amount,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
