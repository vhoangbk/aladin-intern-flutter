import 'package:dna/navigator/navigator_screen/profile_screen.dart';
import 'package:dna/navigator/navigator_screen/welcome_screen.dart';
import 'package:dna/navigator/navigator_widget/language_button.dart';
import 'package:dna/navigator/navigator_widget/navigator_helper.dart';
import 'package:dna/navigator/navigator_widget/social_button_widget.dart';
import 'package:dna/navigator/navigator_widget/input_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


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

  
  Future<T?> pushCupertino<T>(BuildContext context, Widget page) {
    return Navigator.of(context).push<T>(
      CupertinoPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop){
           SystemNavigator.pop();
        }
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
                          SizedBox(
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Text
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Hey there,", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins")),
                                    Text("Create an account", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, fontFamily: "Poppins")),
                                  ],                       
                                ),

                                // Nut o goc phai
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: LanguageButton()
                                )
                              ],
                            )
                          ),
                          SizedBox(height: 20),

                          buildInput(icon: Icon(Icons.person_outline), hint: "First name", controller: _firstNameController),
                          buildInput(icon: Icon(Icons.person_outline), hint: "Last name", controller: _lastNameController),
                          buildInput(icon: Icon(Icons.email), hint: "Email", controller: _emailController),
                          buildInput(icon: Icon(Icons.lock), hint: "Password", controller: _passwordController, obscure: true),

                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (value) {}),
                              const Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: "By continuing your accept our ",
                                    style: TextStyle(fontSize: 10, color: Colors.grey, fontFamily: "Poppins", fontWeight: FontWeight.w400),
                                    children: [
                                      TextSpan(
                                          text: "Privacy Policy",
                                          style: TextStyle(decoration: TextDecoration.underline, fontSize: 10, color: Colors.grey, fontFamily: "Poppins", fontWeight: FontWeight.w400)),
                                      TextSpan(
                                        text: " and ",
                                        style: TextStyle(fontSize: 10, color: Colors.grey, fontFamily: "Poppins", fontWeight: FontWeight.w400),
                                      ),
                                      TextSpan(
                                          text: "Term of use",
                                          style: TextStyle(decoration: TextDecoration.underline, fontSize: 10, color: Colors.black, fontFamily: "Poppins", fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Spacer(),

                          // Nút Register
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                Navigator.push(context, CupertinoPageRoute(builder: (_) => ProfileScreen()));
                              },
                              child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Poppins")),
                            ),
                          ),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(" Or ", style: TextStyle(fontSize: 14, fontFamily: "Inter-Italic-VariableFont_opsz,wght", fontWeight: FontWeight.w400)),
                              ),
                              Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                            ],
                          ),

                          SizedBox(height: 8),
                          SocialButton(),

                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(fontSize: 14, fontFamily: "Poppins", fontWeight: FontWeight.w400, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Login",
                                      style: TextStyle(fontSize: 14, fontFamily: "Poppins", fontWeight: FontWeight.w400, color: Colors.pinkAccent),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          NavigationHelper.pushCupertino(context, WelcomeScreen(fromLogin: true));
                                        },
                                    )
                                  ],
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
          ),
        ),
      ),
    );
  }
}

