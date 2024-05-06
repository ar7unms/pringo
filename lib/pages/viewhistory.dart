import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pringooo/pages/bindhistory.dart';
import 'package:pringooo/pages/bindnotify.dart';
import 'package:pringooo/pages/printhistory.dart';
import 'package:pringooo/pages/printnotify.dart';

class Viewhistory extends StatefulWidget {
  @override
  _ViewhistoryState createState() => _ViewhistoryState();
}

class _ViewhistoryState extends State<Viewhistory> {
  final List<Widget> pages = [
    printhistory(),
    bindhistory()
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      theme: ThemeData(
        primaryColor: Colors.amber, // Set primary color
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      home: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.printer),
              label: "Print",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book),
              label: "Bind",
            ),
          ],
        ),
      ),
    );
  }
}
