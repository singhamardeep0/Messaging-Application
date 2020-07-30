
import 'package:flash_chat/screens/Home_page.dart';
import 'package:flash_chat/screens/friends_screen.dart';
import 'package:flash_chat/screens/Upload_image.dart';
import 'package:flash_chat/screens/messagepage.dart';
import 'package:flash_chat/screens/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';


void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      routes: {
        '/' : (context) => WelcomeScreen(),
        'login' : (context) => LoginScreen(),
        'reg' : (context) => RegistrationScreen(),
        'friend' : (context) => Friends(),
        'mes' : (context) => Messagepage(),
        'otp': (context) => VerifyOtp(),
        'imageupload': (context) => UploadPage(),
        'home' : (context) => Homepage(),
      },
      initialRoute: '/',
    );
  }
}
