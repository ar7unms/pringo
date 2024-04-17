import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pringooo/pages/uploadingscreen.dart';
import 'package:pringooo/services/transactionService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int currentIndex = 0;

  TextEditingController n1=new TextEditingController();
  TextEditingController n2=new TextEditingController();
  TextEditingController n3=new TextEditingController();
  String amount = ""; // Default amount
  bool _isProcessing = false;
  bool isChecked=false;
  String color="";
  String nofpages="";
  String nofcopy="";
  String start="";
  String end="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>uploadScreen1()));
        },
        backgroundColor: Colors.amber,
        child:Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
      body: ListView(children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 13.0,left: 10.0),
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
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {},
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
        ),
        SizedBox(height: 40.0),
        Container(
            height: 900.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                  topRight: Radius.circular(75.0)),
            ),
            child: ListView(
                primary: false,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 45.0),
                      child: Container(
                          height: 800,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: <Widget>[
                                      Center(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20,),
                                            // Background color for the inner container
                                               Center(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    SizedBox(
                                                      height: 100,
                                                      width: 350,
                                                      child:
                                                      TextField(
                                                        controller: n1,
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.black12,
                                                          labelText: "Start",
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 100,
                                                      width: 350,
                                                      child:
                                                      TextField(
                                                        controller: n3,
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.black12,
                                                          labelText: "end",
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 100,
                                                      width: 350,
                                                      child:
                                                      TextField(
                                                        controller: n2,
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.black12,
                                                          labelText: "Number of copy",
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 100,),
                                                        Text('Color',style: TextStyle(fontSize: 20),),
                                                        Checkbox(
                                                          value: isChecked,
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              isChecked = newValue!;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20.0),

                                                    SizedBox(height: 20),
                                                    Text(
                                                      'Amount: $amount',
                                                      style: TextStyle(fontSize: 20.0),
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    _isProcessing
                                                        ? CircularProgressIndicator() // Loading spinner
                                                        : ElevatedButton(
                                                      onPressed: () async {
                                                        start = n1.text;
                                                        end = n3.text;
                                                        nofcopy = n2.text;
                                                        if (isChecked) {
                                                          color = "yes";
                                                        } else {
                                                          color = "no";
                                                        }
                                                        SharedPreferences preference = await SharedPreferences.getInstance();
                                                        preference.setString("start", start);
                                                        preference.setString("end", end);
                                                        preference.setString("noofcopy", nofcopy);
                                                        preference.setString("color", color);
                                                        int startPage = int.parse(start);
                                                        int endPage = int.parse(end);
                                                        nofpages = (endPage - startPage + 1).toString(); // Calculate nofpages
                                                        final response = await transactionApi().calcamount(color, nofpages, nofcopy);
                                                        setState(() {
                                                          if (response["status"] == "success") {
                                                            amount = response["amount"].toString();
                                                            preference.setString("amount", amount);
                                                            print("/////////$amount");
                                                          }
                                                        });


                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => uploadScreen1()));

                                                      },
                                                      child: SizedBox(height:50,width:250,child: Center(child: Text('Pay'))),
                                                    ),

                                                  ],
                                                ),
                                              ),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              ]))),
                ])),
      ]
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
