import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pringooo/models/uploadmodel.dart';
import 'package:pringooo/pages/bindlistpage.dart';
import 'package:pringooo/pages/bindnotify.dart';
import 'package:pringooo/pages/printnotify.dart';
import 'package:pringooo/pages/printorder.dart';
import 'package:pringooo/services/uploadservices.dart';

class viewnotify extends StatefulWidget {
  @override
  _viewnotifyState createState() => _viewnotifyState();
}

class _viewnotifyState extends State<viewnotify> {
  late Future<List<Upload>> data;
  final TextEditingController n1 = TextEditingController();
  final List<Widget> pages = [
    printnotify(),
    bindnotify(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.amber,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.amber),
          unselectedLabelStyle: TextStyle(color: Colors.amber),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.amber,
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              tooltip: "Print Notification",
              icon: Icon(CupertinoIcons.printer),
              label: "PRINT",
            ),
            BottomNavigationBarItem(
              tooltip: "Bind Notification",
              icon: Icon(CupertinoIcons.book),
              label: "BIND",
            ),
          ],
        ),
      ),
    );
  }
}
