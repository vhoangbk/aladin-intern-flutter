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
    return GestureDetector( // Bọc để khi ấn bên ngoài phần bàn phím sẽ tắt 
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, 
        body: SafeArea( // Cố định giao diện
          child: Stack(
            children:[
               // Hinh nen va logo co dinh
               Container(
                 width: double.infinity,
                 height: double.infinity,
                 decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/DNA_BLUE_2103.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Color(0xFF4B1C6F).withOpacity(0.8), BlendMode.darken,)
                  )
                 ),
              // Tao logo
                 alignment: Alignment(0, -0.75),
                 child: Text("DNAfit", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 232, 233, 159)))
               ),

            // Text Field cuon len khi ban phim bi che
               Container(
                 alignment: Alignment.center,
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 30),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       SizedBox(height: 235),
                       // Dung SingleChildScrollView de cuon 
                       SingleChildScrollView(
                         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),

                      
                         child: Column(
                           children: [
                             //Textfield dien User
                             TextField(
                               style: TextStyle(color: Colors.white),
                               decoration: InputDecoration(
                                 hintText: "USERNAME OR EMAIL",
                                 hintStyle: TextStyle(color: Colors.white),
                                 enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                               ),
                             ),

                             SizedBox(height: 10),
                             //TextField dien Password
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
                                 ),
                               ),
                             ),
                             SizedBox(height: 10),
                           ]
                         )
                       )
                     ],
                   )
                 )
               ),
            
               // Tao nut SignIn va ForgotPassword
               Container(
                 alignment: Alignment(0, 0.8),
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     // Tao nut Sign In
                     SizedBox(
                       height: 35,
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

                     SizedBox(height: 5),

                     // Tao nut ForgotPassword
                     SizedBox(
                       height: 30,
                       width: 400,
                       child: TextButton(
                         onPressed: (){}, 
                         child: Text("Forgot Password?", style: TextStyle(color: Colors.white, fontSize: 10),)
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           )
         )
      )
    );  
  }
}

