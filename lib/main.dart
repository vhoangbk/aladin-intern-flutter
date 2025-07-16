

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp ({super.key});
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget
{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/DNA_BLUE_2103.png"),

          //Tao nen mau boc ngoai anh
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
           Color(0xFF4B1C6F).withOpacity(0.8),
           BlendMode.darken,
          ),
         ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children:[
              // Tao logo DNAfit
              SizedBox(height: 200),
              Text("DNAfit", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 232, 233, 159), letterSpacing: 1.2)),
              
              // Tao o TextField nhap Username hoac Email
              SizedBox(height: 300),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "USERNAME OR EMAIL",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  )
                ),
              ),

               // Tao o TextField nhap Password
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "PASSWORD",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  )
                ),
              ),
              
              //Tao nut Sign In
              SizedBox(height: 30),
              SizedBox(
                height: 70,
                width: 400,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.zero
                    )
                  ),
                  onPressed: (){}, 
                  child: (
                    const Text("SIGN IN", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))
                  )
                ),
              ),
              
              // Tao nut forgot password
              SizedBox(height: 10),
              SizedBox(
                height: 70,
                width: 400,
                child: TextButton(
                  style: TextButton.styleFrom(
                     foregroundColor: Colors.white
                  ),
                  onPressed: (){}, 
                  child: (
                    const Text("Forgot Password"))
                  )
                ),
            ]
          )
        )
      )
    );
  }
}


