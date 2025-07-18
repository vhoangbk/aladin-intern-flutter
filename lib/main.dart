import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final PageController _controller = PageController();
final List<Map<String, dynamic>> pages = [
  {
  "image" : "assets/bong_da.jpeg",
  "title" : "Welcome to CaStore!",
  "subtitle" : "With long experience in the audio industry,",
  "subtitle2" : "we create the best quality products"
  },

  {
  "image" : "assets/bong_ro.jpeg",
  "title" : "Welcome to CaStore!",
  "subtitle" : "Our extensive experience in the audio field",
  "subtitle2" : "allows us to deliver top-quality products."
  },

  {
  "image" : "assets/cau_long.jpeg",
  "title" : "Welcome to CaStore!",
  "subtitle" : "Thanks to years of expertise in audio technology,",
  "subtitle2" : "we produce products of the highest quality."
  }
];


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      home: const BoardingScreen(),
    );
  }
}

class BoardingScreen extends StatefulWidget
{
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(     
            controller: _controller,
            itemCount: pages.length,
            itemBuilder: (context, index){
              return Column(
                children: [
                  //const SizedBox(height: 100),
                  Container(
                     height: 400,
                     width: double.infinity,
                     child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                         Image.asset(
                           pages[index]["image"]!,
                           height: 400,
                           width: double.infinity,
                           fit: BoxFit.cover,
                          ),
                         Positioned(
                            child: SmoothPageIndicator(
                              controller: _controller, 
                              count: pages.length,
                              effect: WormEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                activeDotColor: Colors.yellow
                              )
                            ),
                          ),

                      ],)
                  ),

                  Text(
                    pages[index]['title']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    pages[index]['subtitle']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    pages[index]['subtitle2']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],            
              );
            }
          ),

          
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(             
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  height: 90,
                  width: 380,
                  padding: EdgeInsets.all(16.0),               
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.zero
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: (){}, 
                    child: Row(  
                       mainAxisAlignment: MainAxisAlignment.end,                 
                       children: [
                         Text("Get Started", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                         SizedBox(width: 80),
                         Icon(Icons.arrow_forward, color: Colors.black),
                       ],
                    )
                  )
                )
            )
          )
        ]
      )
    );
  }
}

