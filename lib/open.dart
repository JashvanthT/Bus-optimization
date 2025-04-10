import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:busapp/home.dart';
import 'package:busapp/last.dart';
import 'package:busapp/show.dart';
import 'package:busapp/stud.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Entrance(studentName: "Guest"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Entrance extends StatefulWidget {
  final String studentName; // Receiving name from Academic page

  const Entrance({super.key, required this.studentName});

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome\n${widget.studentName}", // Updated to display dynamic name
              style: TextStyle(
                fontFamily: "TimeNewRoman",
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(13.0827, 80.2707), // Chennai coordinates
                    zoom: 13.0,
                    interactiveFlags: InteractiveFlag.all, // Enables zoom & pan
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.example.busapp',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Detail()));
          } else if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Last()));
          }
        },
      ),
    );
  }
}
