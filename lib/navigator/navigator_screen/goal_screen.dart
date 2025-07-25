import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class GoalScreen extends StatefulWidget {
  @override
  State<GoalScreen> createState() => _StateGoalScreen();
}

class _StateGoalScreen extends State<GoalScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/bong_da.jpeg",
      "title": "Improve Shape",
      "description": "I have a low amount of body fat",
      "description2": "and need / want to build more",
      "description3": "muscle"
    },
    {
      "image": "assets/bong_ro.jpeg",
      "title": "Lean & Tone",
      "description": "I'm 'skinny fat', look thin but have",
      "description2": "no shape. I want to learn to build",
      "description3": "muscle in the right way"
    },
    {
      "image": "assets/cau_long.jpeg",
      "title": "Lose a Fat",
      "description": "I have over 20 lbs to lose. I want to",
      "description2": "drop all this fat and gain muscle",
      "description3": "mass",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        context.go('/profile');
        return false;        
      },
           
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              //Phan text tren cung
              const Text(
                "What is your goal ?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 8),
              const Text(
                "It will help us to choose a best",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 3),
              const Text(
                "program for you",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 16),

              // Phan anh va o o trung tam
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        // Phan hop duoc boc ngoai anh va chu
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade100, Colors.blue.shade200],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Phan anh
                            Expanded(
                              child: Image.asset(
                                page["image"]!,
                                fit: BoxFit.contain,
                              ),
                            ),

                            //Tieu de
                            const SizedBox(height: 16),
                            Text(
                              page["title"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"
                              ),
                            ),

                            // Duong ke ngan cach
                            const SizedBox(height: 2),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 100),
                              child: Divider(thickness: 1, color: Colors.white),
                            ),

                            //Text dong 1
                            const SizedBox(height: 5),
                            Text(
                              page["description"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                            ),

                            // Text dong 2
                            const SizedBox(height: 3),
                            Text(
                              page["description2"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                            ),

                            // Text dong 3
                            const SizedBox(height: 3),
                            Text(
                              page["description3"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Button Confirm
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {                   
                      context.go('/welcome');
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Poppins"
                      ),
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


