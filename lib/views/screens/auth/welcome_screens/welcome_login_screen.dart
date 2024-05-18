import 'package:farmpicks/views/screens/auth/loginscreen.dart';
import 'package:farmpicks/views/screens/auth/welcome_screens/welcome_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeLoginScreen extends StatelessWidget {
  const WelcomeLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Colors.pink,
        ),
        child: Stack(clipBehavior: Clip.hardEdge, children: [
          Positioned(
              left: screenWidth * 0.024,
              top: screenHeight * 0.151,
              child: Image.asset(
                'assets/icons/Illustration.png',
              )),
          Positioned(
              top: screenHeight * 0.780,
              left: screenWidth * 0.24,
              child: Container(
                width: screenWidth * 0.55,
                height: screenHeight * 0.085,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white,
                ),
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return LoginScreen();
                      }));
                    },
                    child: Text(
                      'Login ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              )),

          Positioned(
              top: screenHeight * 0.88,
              left: screenWidth * 0.20,
              child: Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return WelcomeRegisterScreen();
                        }));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
