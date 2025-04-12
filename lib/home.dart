import 'package:busapp/login.dart';
import 'package:busapp/main.dart';
import'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
  Widget build(BuildContext context) {
      double screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Let's\nGet\nStarted",
                      style: TextStyle(
                          fontFamily: "TimeNewRoman",
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          height: 0.9
                      )
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width -20,
                      child: Image.asset("assets/images/bus.png",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,)),
                  SizedBox(height: 25,),

                  Text("Section title",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  Text("Welcome to the app please sign in to know th bus details",
                  style:TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic
                  ),
                  ),
                  SizedBox(height: 50,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-40,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Login()),
                      );
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFE5637),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 100,vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black,

                        ), child:Text("Sign In",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),)),
                  )


                ],
              ),
            ),
          ),


    );
  }
}

