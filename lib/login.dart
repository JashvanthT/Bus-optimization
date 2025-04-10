import 'package:busapp/home.dart';
import 'package:busapp/stud.dart';
import 'package:flutter/material.dart';
import 'package:busapp/phone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  TextEditingController numControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  String? emailError;
  String? passwordError;

  void validateAndLogin() {
    setState(() {
      // Email validation: should end with "@gmail.com"
      if (numControl.text.isEmpty) {
        emailError = 'Please enter e-mail id';
      } else if (!numControl.text.endsWith('@gmail.com')) {
        emailError = 'Please enter a valid Gmail address';
      } else {
        emailError = null;
      }

      // Password validation: should have at least 10 characters and include numbers
      if (passwordControl.text.isEmpty) {
        passwordError = 'Please enter password';
      } else if (passwordControl.text.length < 10) {
        passwordError = 'Password must be at least 10 characters long';
      } else if (!RegExp(r'[0-9]').hasMatch(passwordControl.text)) {
        passwordError = 'Password must contain at least one number';
      } else {
        passwordError = null;
      }
    });

    if (emailError == null && passwordError == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Academic()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Login\nAccount",
                        style: TextStyle(
                          fontFamily: "TimeNewRoman",
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/login.png",
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.width * 0.35,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFE5637),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Text("E-mail"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Phone()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEFF1F5),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Text(
                        "Phone number",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              TextField(
                controller: numControl,
                decoration: InputDecoration(
                  labelText: "Enter e-mail id",
                  filled: true,
                  fillColor: Color(0xFFEFF1F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: emailError,
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: passwordControl,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Color(0xFFEFF1F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorText: passwordError,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text("Forget Password?", style: TextStyle(color: Colors.blue)),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: validateAndLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFE5637),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
