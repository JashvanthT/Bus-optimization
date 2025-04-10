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
      debugShowCheckedModeBanner: false,
      home: Otp(),
    );
  }
}

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final List<TextEditingController> _otpControllers =
  List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Fixes the overlap issue
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "OTP\nVerification",
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    height: 0.9,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/otp.png",
                          width: 180, height: 180),
                      SizedBox(height: 15),
                      Text(
                        "Verification Code",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "We have sent you a verification\ncode to your phone number",
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      // OTP Input Fields
                      Form(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 50,
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                controller: _otpControllers[index],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "", // Hide character counter
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 3) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Academic()));
                          },
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}