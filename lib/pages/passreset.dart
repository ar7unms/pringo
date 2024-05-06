import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pringooo/pages/LoginScreen.dart';
import 'package:pringooo/pages/uploadingscreen.dart';
import 'package:pringooo/services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'card_textfield.dart';

class Passreset extends StatefulWidget {
  const Passreset({Key? key});

  @override
  State<Passreset> createState() => _PassresetState();
}

class _PassresetState extends State<Passreset> {
  TextEditingController pass1=new TextEditingController();
  TextEditingController pass2=new TextEditingController();
  TextEditingController token=new TextEditingController();

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
                                  child: GridView.count(
                                    crossAxisCount: 1,
                                    scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.all(25),
                                    children: <Widget>[
                                      Center(
                                        child: Column(
                                          children: [
                                            //SizedBox(height: 3,),
                                            CardTextField(
                                                labelText: "Enter password",
                                                icon: Icons.key,
                                                obscureText: false,
                                                controller: pass1),
                                            SizedBox(height: 20.0),
                                            CardTextField(
                                                labelText: "Reenter password",
                                                icon: Icons.key,
                                                obscureText: false,
                                                controller: pass2),
                                            CardTextField(
                                                labelText: "Token",
                                                icon: Icons.key,
                                                obscureText: false,
                                                controller: token),
                                            SizedBox(height: 20.0),
                                            ElevatedButton(
                                              onPressed:()async{

                                                String password1=pass1.text;
                                                String password2=pass2.text;
                                                String tokenn=token.text;
                                                SharedPreferences p = await SharedPreferences.getInstance();
                                                String emailid = p.getString("emailid") ?? "";
                                                
                                                  final response= await userApiservice().resetpassword(emailid, password2, tokenn);

                                                if(response["status"]=='Email sent successfully'){
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('Password reseted')),
                                                  );
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                                  }
                                              },
                                              child: Text(
                                                'SEND',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0),
                                                ),
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
