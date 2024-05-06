import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pringooo/pages/LoginScreen.dart';
import 'package:pringooo/pages/bindtransaction.dart';
import 'package:pringooo/pages/printhistory.dart';
import 'package:pringooo/pages/transactionpage.dart';
import 'package:pringooo/pages/viewhistory.dart';
import 'package:pringooo/pages/viewnotfy.dart';
import 'package:pringooo/pages/viewtransaction.dart';

import 'card_textfield.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> labels = ["Phone", "Video", "Audio", "Document"];
  int currentIndex = 0;
  String tit = 'Upload File';
  String sub = 'Browse and chose the files you want to upload.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        backgroundColor: Colors.amber,
        child:Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: ListView(children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 15.0,left: 10.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {},
              ),
              Container(
                  width: 125.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.filter_list),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewNotify()));
                        },
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.menu,color: Colors.white,),
                        itemBuilder:(BuildContext context)=><PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value:'Sign out',
                            child: Text("SIGN OUT"),
                          ),
                          PopupMenuItem<String>(
                            value:'Transactions',
                            child: Text("Transactions"),
                          ),
                        ],
                        onSelected: (String value){
                          switch(value){
                            case 'Sign out':
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Do you wanna signout ?'),
                                    content: Text('SIGN OUT ?',textAlign: TextAlign.center,),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            case 'Transactions':
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewTransactionPage()));
                          }
                        },
                      )
                    ],
                  )
              )
            ],
          ),
        ),
        SizedBox(height: 25.0),
        Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Row(
            children: <Widget>[
             SizedBox(width: 400,
               child: ElevatedButton(onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context) => Viewhistory()));
                           },
                child: Text("VIEW HISTORY"),),
             ),
              SizedBox(width: 10.0),

            ],
          ),
        ),
        SizedBox(height: 40.0),
        Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  topRight: Radius.circular(75.0)),
            ),
            child: ListView(
                primary: false,
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 45.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height - 300.0,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.all(25),
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionPage()));
                                            },
                                              child: SizedBox(width: 400,
                                                child: Card(
                                                  color: Colors.amber,
                                                  elevation: 5,
                                                  margin: EdgeInsets.all(10),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          height: 500,
                                                          width: 350,
                                                          decoration: BoxDecoration(
                                                            color: Colors.amber
                                                          ),
                                                          child:
                                                          SvgPicture.asset(
                                                            'assets/undraw_printing_invoices_-5-r4r.svg',
                                                            width: 100, // Set the width of the SVG image
                                                            height: 100, // Set the height of the SVG image
                                                          ),
                                                        ),
                                                        SizedBox(height: 60),
                                                        Center(
                                                          child: Text(
                                                            "COPY",
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20.5,
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text('CLICK TO COPY',
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                              color: Colors.grey[800],
                                                              fontWeight: FontWeight.w100,
                                                              fontSize: 12.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>transactionPage()));
                                            },
                                            child: SizedBox(width: 400,
                                              child: Card(
                                                color: Colors.amber,
                                                elevation: 5,
                                                margin: EdgeInsets.all(10),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: <Widget>[
                                                      Container(
                                                        height: 500,
                                                        width: 350,
                                                        decoration: BoxDecoration(
                                                            color: Colors.amber
                                                        ),
                                                        child:
                                                        SvgPicture.asset(
                                                          'assets/undraw_education_f8ru.svg',
                                                          width: 100, // Set the width of the SVG image
                                                          height: 100, // Set the height of the SVG image
                                                        ),
                                                      ),
                                                      SizedBox(height: 60),
                                                      Center(
                                                        child: Text(
                                                          "BINDING",
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.5,
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text('CLICK TO BIND',
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors.grey[800],
                                                            fontWeight: FontWeight.w100,
                                                            fontSize: 12.5,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ]))),
                ])),
      ]
      ),      drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Handle item 2 tap
            },
          ),
        ],
      ),
    ),

    );
  }
}
