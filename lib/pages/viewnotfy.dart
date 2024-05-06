import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pringooo/pages/bindnotify.dart';
import 'package:pringooo/pages/printnotify.dart';

class ViewNotify extends StatefulWidget {
  @override
  _ViewNotifyState createState() => _ViewNotifyState();
}

class _ViewNotifyState extends State<ViewNotify> {
  final List<Widget> pages = [
    printnotify(),
    bindnotify()
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

void main() {
  runApp(ViewNotify());
}
