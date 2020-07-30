//import 'package:flash_chat/screens/otp_page.dart';
//import 'package:flutter/material.dart';
//
//
//class PhoneNumber extends StatefulWidget {
//  @override
//  _PhoneNumberState createState() => _PhoneNumberState();
//}
//
//class _PhoneNumberState extends State<PhoneNumber> {
//  String phno;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Padding(
//        padding: const EdgeInsets.all(16.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            TextField(
//              textAlign: TextAlign.center,
//              style: TextStyle(color: Colors.white70),
//              onChanged: (value) {
//                phno = value;
//              },
//              decoration: InputDecoration(
//                hintText: 'Enter your Phone Number',
//                hintStyle: TextStyle( color: Colors.black),
//                contentPadding:
//                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                ),
//                enabledBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
//                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                ),
//                focusedBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                ),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.symmetric(vertical: 16.0),
//              child: Material(
//                color: Colors.blueAccent,
//                borderRadius: BorderRadius.circular(30.0),
//                elevation: 5.0,
//                child: MaterialButton(
//                  onPressed: () {
//
//                    Navigator.push(
//                        context,
//                        new MaterialPageRoute(
//                            builder: (BuildContext context) =>
//                                VerifyOtp()));
//                  },
//                  minWidth: 200.0,
//                  height: 42.0,
//                  child: Text(
//                    'Send OTP',
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
