import 'package:dna/navigator/navigator_widget/social_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dna/navigator/navigator_widget/input_widget.dart';
import 'package:go_router/go_router.dart';


// Màn hình 5

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
  });
  @override
  State<WelcomeScreen> createState() => _StateWelcomeScreen();
}



class _StateWelcomeScreen extends State<WelcomeScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    
    final fromLogin = GoRouterState.of(context).uri.queryParameters['fromLogin'] == 'true';

    return WillPopScope(      
      onWillPop:() async{
        if (fromLogin) {
          context.go('/createprofile'); // quay lại màn 2
          return false;
        } else {
          context.go('/goal'); // hoặc context.go('/profile'); tùy trường hợp
          return false;
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Hey there,", style: TextStyle(fontSize: 16, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf", fontWeight: FontWeight.w400)),
                            Text("Welcome back",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf")),
                            buildInput(
                              icon: Icon(Icons.email),
                              hint: "Email",
                              controller: _emailController
                            ),
                            SizedBox(height: 10),
                            buildInput(
                              icon: Icon(Icons.lock),
                              hint: "Password",
                              controller: _passwordController,
                              obscure: true
                            ),
                            SizedBox(height: 5),
                            Text("Forgot your password?", style: TextStyle(decoration: TextDecoration.underline, fontSize: 12, color: Colors.grey, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf", fontWeight: FontWeight.w500)),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
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
                                    //context.go('/main');  
                                    context.go(
                                      Uri(
                                        path: '/main',
                                        queryParameters: {'fromLogin': 'true'},
                                      ).toString(),
                                    );      
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.login, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text("Login", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "assets/font_Poppin/Poppins-Bold.ttf")),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(thickness: 1, color: Colors.grey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(" Or ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "assets/font_Inter/Inter-Italic-VariableFont_opsz,wght.ttf")),
                                ),
                                Expanded(
                                  child: Divider(thickness: 1, color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),

                            //Nút button gg và facebook
                            SocialButton(),
                            
                            // Phan Text duoi cung
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Don't have an account yet? ",
                                    style: TextStyle(fontSize: 14, fontFamily: String.fromEnvironment("Poppins"), fontWeight: FontWeight.w400, color: Colors.black),

                                    // Xu li Register dieu huong
                                    children: [
                                      TextSpan(
                                        text: "Register",
                                        style: TextStyle(fontSize: 14, fontFamily: String.fromEnvironment("Poppins"), fontWeight: FontWeight.w400, color: Colors.pinkAccent),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.go('/createprofile');
                                          }
                                      ) 
                                    ]
                                  )
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      )  
    );    
  }
}

/*context.go('/goal'); // Quay lại HomeScreen
        return false; // Ngăn pop mặc định*/

// ✅ WelcomeScreen.dart (updated to meet your exact logic)

