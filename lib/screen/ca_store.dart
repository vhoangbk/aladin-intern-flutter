import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

int currentIndex = 0;
final PageController _controller = PageController();
final List<Map<String, dynamic>> pages = [
  {
    "image": "assets/bong_da.jpeg",
    "subtitle": "With long experience in the audio industry,",
    "subtitle2": "we create the best quality products"
  },
  {
    "image": "assets/bong_ro.jpeg",
    "subtitle": "Our extensive experience in the audio field",
    "subtitle2": "allows us to deliver top-quality products."
  },
  {
    "image": "assets/cau_long.jpeg",
    "subtitle": "Thanks to years of expertise in audio technology,",
    "subtitle2": "we produce products of the highest quality."
  }
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BoardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // PHẦN ẢNH + SMOOTH
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      pages[index]["image"],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: pages.length,
                    effect: const WormEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PHẦN TEXT VÀ NÚT BẤM CỐ ĐỊNH PHÍA DƯỚI
          const SizedBox(height: 30),
          Container(
            //padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                // Phần text cố định
                const Text(
                  "Welcome to CaStore !",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),

                // Phần text thay đổi khi kéo 
                const SizedBox(height: 10),
                SizedBox(
                  height: 20,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      pages[currentIndex]["subtitle"] ?? '',
                      key: ValueKey(currentIndex),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      pages[currentIndex]["subtitle2"] ?? '',
                      key: ValueKey('s2-$currentIndex'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),

                // NÚT BẤM
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 70),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
