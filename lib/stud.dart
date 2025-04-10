import 'package:flutter/material.dart';
import 'package:busapp/home.dart';
import 'package:busapp/open.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Academic(),
    );
  }
}

class Academic extends StatefulWidget {
  const Academic({super.key});

  @override
  State<Academic> createState() => _AcademicState();
}

class _AcademicState extends State<Academic> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController boardingController = TextEditingController();
  String? selectedGender;
  String? selectedStatus; // NEW FIELD

  Future<void> submitStudentData() async {
    final String apiUrl = "http://10.0.2.2:5000/add_student";

    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Entrance(studentName: nameController.text),
      ),
    );

    Future.delayed(Duration.zero, () async {
      try {
        await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": nameController.text,
            "digital_id": idController.text,
            "boarding_point": boardingController.text,
            "gender": selectedGender,
            "attendance": selectedStatus

          }),
        );
      } catch (e) {
        print("Failed to connect to server: $e");
      }
    });

    try {
      await FirebaseFirestore.instance.collection('students').doc(nameController.text).set({
        'name': nameController.text,
        'digital_id': idController.text,
        'boarding_point': boardingController.text,
        'gender': selectedGender,
        'attendance': selectedStatus,

        'timestamp': FieldValue.serverTimestamp(),
      });
      print(" Data saved to Firebase");
    } catch (e) {
      print(" Failed to save to Firebase: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Academic\nDetails",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "TimesNewRoman",
                        fontSize: 30),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/images/student.png",
                    width: 150,
                    height: 120,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Enter Full name",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Full name is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: idController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter Digital ID",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Digital ID is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: boardingController,
                          decoration: InputDecoration(
                            labelText: "Enter Boarding Point",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Boarding Point is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        DropdownButtonFormField<String>(
                          value: selectedGender,
                          decoration: InputDecoration(
                            labelText: "Select Gender",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: ["Male", "Female"].map((String gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Gender is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),

                        // ✅ NEW Present/Absent Field
                        DropdownButtonFormField<String>(
                          value: selectedStatus,
                          decoration: InputDecoration(
                            labelText: "Select Attendance",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: ["Present", "Absent"].map((String status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return "Attendance status is required";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: submitStudentData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFE5637),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
