import 'package:dna/navigator/navigator_screen/create_account_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:dna/navigator/navigator_screen/main_screen.dart';
import 'package:dna/navigator/navigator_widget/input_widget.dart';
import 'package:dna/navigator/navigator_widget/social_button_widget.dart';
import 'package:dna/navigator/navigator_widget/navigator_helper.dart';

// Màn hình 5
class WelcomeScreen extends StatefulWidget {
  final bool fromLogin; //  Nhận giá trị truyền vào để phân biệt luồng
  const WelcomeScreen({super.key, required this.fromLogin});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  // Xử lý nút back Android hoặc gesture swipe thủ công
  Future<bool> _handleBack() async {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).maybePop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result){
        if(!didPop){
          Navigator.of(context).maybePop();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 5) {
            _handleBack(); // Vuốt sang phải để quay lại
          }
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Hey there,".tr(), style: TextStyle(fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.w400)),
                          Text("Welcome back".tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppins")),
                          buildInput(icon: Icon(Icons.email), hint: "Email".tr(), controller: _emailController),
                          SizedBox(height: 10),
                          buildInput(icon: Icon(Icons.lock), hint: "Password".tr(), controller: _passwordController, obscure: true),
                          SizedBox(height: 5),
                          Text("Forgot your password?".tr(),
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500)),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  NavigationHelper.pushCupertino(context, const MainScreen(fromLogin: true));

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.login, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text("Login".tr(), style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "Poppins")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(" Or ".tr(),
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Inter")),
                              ),
                              Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(height: 3),
                          SocialButton(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: "Don't have an account yet? ".tr(),
                                  style: TextStyle(fontSize: 14, fontFamily: "Poppins", fontWeight: FontWeight.w400, color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Register".tr(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.pinkAccent),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          NavigationHelper.pushCupertino(context, CreateAccountScreen());
                                        },
                                    ),
                                  ],
                                ),
                              ),
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


