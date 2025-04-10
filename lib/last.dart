import 'package:busapp/home.dart';
import 'package:busapp/show.dart'; // Importing show.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Last(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Last extends StatefulWidget {
  const Last({super.key});

  @override
  State<Last> createState() => _LastState();
}

class _LastState extends State<Last> {
  int _selectedIndex = 2; // Settings tab is selected

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Detail()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Arrow & Settings in the same row
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 28, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                ),
                SizedBox(width: 5),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between Settings & Name

            // Settings Options
            ListTile(
              title: Text(
                "Account Center",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.account_circle, size: 28, color: Colors.black),
            ),

            ListTile(
              title: Text(
                "About Us",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.info, size: 28, color: Colors.black),
            ),

            ListTile(
              title: Text(
                "Terms & Conditions",
                style: TextStyle(fontSize: 20),
              ),
              trailing: Icon(Icons.description, size: 28, color: Colors.black),
            ),

            Spacer(),

            // Log-Out Row
            Row(
              children: [
                Text(
                  "Log-Out",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.logout, size: 24, color: Colors.red),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
      ),
    );
  }
}
