import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final PageController _controller = PageController();

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
      body: Column(
        children: [
          // Phan anh co the keo qua lai
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                Image.asset("assets/bong_da.jpeg", fit: BoxFit.cover),
                Image.asset("assets/bong_ro.jpeg", fit: BoxFit.cover),
                Image.asset("assets/cau_long.jpeg", fit: BoxFit.cover)
              ],
            ),
          ),

          SmoothPageIndicator(
            controller: _controller,
            count: 3, 
            effect: WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Colors.black
            )
          ),

          
          
          // Phan Text va nut bam co dinh
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                // Phan Text
                Text("Welcome to CaStore !", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 5),
                Text("With long experience in the audio industry, ", textAlign: TextAlign.center, style: TextStyle(fontSize: 10),),
                SizedBox(height: 5),
                Text("we create the best quality products", textAlign: TextAlign.center, style: TextStyle(fontSize: 10),),
                SizedBox(height: 5),

                // Phan nut bam
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.yellow,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadiusGeometry.zero
                       )
                    ),
                    onPressed: (){}, 
                    child: Row(  
                      mainAxisAlignment: MainAxisAlignment.end,                 
                      children: [
                         Text("Get Started", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                         SizedBox(width: 70),
                         Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    )
                  )
                )                
              ],             
            ),
          )
        ]
      )
    );  
  }
}









 
/*Container(
            height: 400,
            width: 400,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: onBoardingScreen.map((image) {
                  return Container(
                    width: 400,
                    height: 400,
                    child: Image.asset(image, fit: BoxFit.cover)
                  );
                }).toList()
              )              
            )
          ),*/
