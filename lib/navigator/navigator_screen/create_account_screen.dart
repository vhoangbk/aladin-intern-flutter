import 'package:dna/navigator/navigator_widget/social_button_widget.dart';
import 'package:dna/navigator/navigator_widget/input_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Màn hình 2

class CreateAccountScreen extends StatefulWidget {
  @override
  State<CreateAccountScreen> createState() => _StateCreateAccountScreen();
}

class _StateCreateAccountScreen extends State<CreateAccountScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //context.go('/'); // Quay lại HomeScreen
        return true; // Ngăn pop mặc định
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Text
                          Text("Hey there,", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf")),
                          Text("Create an account", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf")),
                          SizedBox(height: 20),

                          //Cac o nhap lieu
                          buildInput(
                              icon: Icon(Icons.person_outline),
                              hint: "First name",
                              controller: _firstNameController),
                          buildInput(
                              icon: Icon(Icons.person_outline),
                              hint: "Last name",
                              controller: _lastNameController),
                          buildInput(
                              icon: Icon(Icons.email),
                              hint: "Email",
                              controller: _emailController),
                          buildInput(
                              icon: Icon(Icons.lock),
                              hint: "Password",
                              controller: _passwordController,
                              obscure: true),

                          // Dong y cac dieu khoan
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (value) {}),
                              const Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: "By continuing your accept our ",
                                    style: TextStyle(fontSize: 10, color: Colors.grey, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf", fontWeight: FontWeight.w400),
                                    children: [
                                      TextSpan(
                                          text: "Privacy Policy",
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 10,
                                              color: Colors.grey, 
                                              fontFamily: "assets/font_Poppin/Poppins-Bold.ttf",
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: " and ",
                                        style: TextStyle(fontSize: 10, color: Colors.grey, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf", fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                          text: "Term of use",
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              fontSize: 10,
                                              color: Colors.black,
                                              fontFamily: "assets/font_Poppin/Poppins-Bold.ttf", 
                                              fontWeight: FontWeight.w400
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Spacer(),

                          // Button Register
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
                                context.go('/profile');
                              },                   
                              child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf")),
                            )
                          ),

                          SizedBox(height: 10),

                          // Duong ke ngan cach va chu Or
                          Row(
                            children: [
                              Expanded(
                                child: Divider(thickness: 1, color: Colors.grey),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(" Or ", style: TextStyle(fontSize: 14, fontFamily: "assets/font_Inter/Inter-Italic-VariableFont_opsz,wght.ttf", fontWeight: FontWeight.w400)),
                              ),
                              Expanded(
                                child: Divider(thickness: 1, color: Colors.grey),
                              ),
                            ],
                          ),

                          SizedBox(height: 8),

                          //Button gg va facebook
                          SocialButton(),

                          //Text cuoi dong
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(fontSize: 14, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf", fontWeight: FontWeight.w400, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Login",
                                      style: TextStyle(fontSize: 14, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf", fontWeight: FontWeight.w400, color: Colors.pinkAccent),
                                      //An vao login se chuyen sang trang dang nhap 
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          context.go(
                                            Uri(
                                              path: '/welcome',
                                              queryParameters: {'fromLogin' : 'true'}
                                            ).toString()
                                          );                                          
                                        }
                                    )
                                  ]
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ),
      ),
    );
  }
}
