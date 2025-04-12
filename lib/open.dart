import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:busapp/home.dart';
import 'package:busapp/last.dart';
import 'package:busapp/show.dart';
import 'package:busapp/stud.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  final String studentName;

  const Entrance({super.key, required this.studentName});

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  bool isPresent = true;

  // 🔥 Added controllers and location map
  late final MapController _mapController;
  TextEditingController _searchController = TextEditingController();

  Map<String, LatLng> locationMap = {
    '29': LatLng(13.0827, 80.2707),
    '36': LatLng(13.0855, 80.2483),
    '4': LatLng(13.0604, 80.2496),
  };

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  Future<void> updateAttendance(bool present) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.studentName)
          .update({
        'attendance': present ? 'Present' : 'Absent',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Marked as ${present ? 'Present' : 'Absent'}'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      print("Error updating attendance: $e");
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
            Text(
              "Welcome\n${widget.studentName}",
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
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(13.0827, 80.2707),
                    zoom: 13.0,
                    interactiveFlags: InteractiveFlag.all,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.example.busapp',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(13.0827, 80.2707),
                          width: 30,
                          height: 30,
                          child: Icon(Icons.location_on, color: Colors.red, size: 30),
                        ),
                        Marker(
                          point: LatLng(13.0855, 80.2483),
                          width: 30,
                          height: 30,
                          child: Icon(Icons.location_on, color: Colors.green, size: 30),
                        ),
                        Marker(
                          point: LatLng(13.0604, 80.2496),
                          width: 30,
                          height: 30,
                          child: Icon(Icons.location_on, color: Colors.blue, size: 30),
                        ),
                        Marker(
                          point: LatLng(13.0700, 80.2400),
                          width: 30,
                          height: 30,
                          child: Icon(Icons.location_on, color: Colors.orange, size: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFFFAE8E8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_user, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        "Attendance: ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        isPresent ? "Present" : "Absent",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isPresent ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: isPresent,
                    onChanged: (value) async {
                      setState(() {
                        isPresent = value;
                      });
                      await updateAttendance(value);
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchController,
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
                    onSubmitted: (value) {
                      if (locationMap.containsKey(value.trim())) {
                        LatLng newLoc = locationMap[value.trim()]!;
                        _mapController.move(newLoc, 16.0);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Location number not found')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
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
            print("already in home page");
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
