import 'package:flutter/material.dart';
import 'package:pringooo/pages/home.dart';
import 'package:pringooo/services/userservice.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = "", phoneNumber = "", email = "", password = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp() async {
    name = nameController.text;
    phoneNumber = phoneNumberController.text;
    email = emailController.text;
    password = passwordController.text;

    print("Name: $name");
    print("Phone Number: $phoneNumber");
    print("Email: $email");
    print("Password: $password");

    final response = await userApiservice().Sentdata(name, phoneNumber, email, password);
    if (response["status"] == "success") {

      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      // Navigate to the home page or any other screen after successful sign up
    }
    else if(response["status"] == "Email already exists"){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already exists')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100.0, left: 40.0, right: 40.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      // Navigate back to the previous screen
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                CardTextField(
                  controller: nameController,
                  labelText: 'Name',
                  icon: Icons.person,
                  obscureText: false,
                ),
                SizedBox(height: 20.0),
                CardTextField(
                  controller: phoneNumberController,
                  labelText: 'Phone Number',
                  icon: Icons.phone,
                  obscureText: false,
                ),
                SizedBox(height: 20.0),
                CardTextField(
                  controller: emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                  obscureText: false,
                ),
                SizedBox(height: 20.0),
                CardTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: signUp,
                  child: Text(
                    'SIGN UP',
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
