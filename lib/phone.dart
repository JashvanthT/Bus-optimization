import 'package:busapp/login.dart';
import 'package:flutter/material.dart';
import 'package:busapp/otp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Phone(),
    );
  }
}

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController numControl = TextEditingController();
  String? errorMessage; // Stores the error message

  void validateAndProceed() {
    String phoneNumber = numControl.text.trim();

    setState(() {
      if (phoneNumber.isEmpty) {
        errorMessage = "Phone number cannot be empty";
      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber)) {
        errorMessage = "Enter a valid 10-digit phone number";
      } else {
        errorMessage = null;
        Navigator.push(context, MaterialPageRoute(builder: (context) => Otp()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Login\nAccount",
                      style: TextStyle(
                        fontFamily: "TimeNewRoman",
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        height: 0.9,
                      ),
                    ),
                  ),
                  Image.asset("assets/images/login.png",
                      width: 130, height: 130),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEFF1F5),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                      ),
                      child: Text(
                        "E-mail",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFE5637),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                      ),
                      child: Text("Phone number"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Phone Number Input
              TextField(
                controller: numControl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter phone number",
                  filled: true,
                  fillColor: Color(0xFFEFF1F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Error Message
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              SizedBox(height: 30),

              // Request OTP Button
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: validateAndProceed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFE5637),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Request OTP",
                    style: TextStyle(color: Colors.white),
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