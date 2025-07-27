import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Màn hình 1

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _StateHomeScreen();
}

class _StateHomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              children: [
                //Text ở trung tâm
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fitnest",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                          fontFamily: "assets/font_Poppin/Poppins-Bold.ttf",
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "X",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.deepPurpleAccent,
                          fontFamily: "assets/font_Poppin/Poppins-Bold.ttf",
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                //Text ở dòng dưới
                Text("Everybody can train", style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontFamily: "assets/font_Poppin/Poppins-Bold.ttf",
                  fontWeight: FontWeight.w400
                ),),
              ],
            ),

            //Button 
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  context.go('/createprofile');
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

