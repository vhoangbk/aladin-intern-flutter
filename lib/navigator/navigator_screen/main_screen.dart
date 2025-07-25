import 'package:flutter/material.dart';
import 'package:dna/navigator/navigator_screen/tabbar_screen.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _StateMainScreen();
}

class _StateMainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        context.go('/welcome');
        return false;        
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Phan anh tren cung
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  child: Image.asset("assets/juventus.jpg"),
                ),

                // Phan Text o duoi
                SizedBox(height: 16),
                Text(
                  "Welcome, Stefani",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                ),
                Text("You are all set now, let’s reach your", style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w400),),
                Text("goals together with us", style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: "Poppins", fontWeight: FontWeight.w400),),
                Spacer(),

                // Button Go to home
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabbarScreen()));
                    },
                    child: Text("Go to home", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Poppins"))
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}



