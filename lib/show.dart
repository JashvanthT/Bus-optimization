import 'package:busapp/home.dart';
import 'package:busapp/last.dart'; // Import last.dart for settings page
import 'package:busapp/open.dart';
import 'package:flutter/material.dart';
import 'package:busapp/stud.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Detail(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Detail extends StatefulWidget {

  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // Navigates back
                  },
                ),
                SizedBox(width: 20),
                Text(
                  "Nearby Stop",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "TimeNewRoman",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Text(
                "Nearby bus stops will appear here",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin, size: 35),
            label: "Location",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 35),
            label: "Settings",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Entrance(studentName: "guest")));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Last()));
          }
        },
      ),
    );
  }
}
