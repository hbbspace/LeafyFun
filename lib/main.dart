import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/otp_verification.dart';
import 'package:leafyfun/Screens/splashscreen.dart';
// import 'package:leafyfun/Screens/homepage1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LeafyFun',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        // home: Article1());
        home: SplashScreen());
    // home: OtpVerificationPage());
    // home: MyHomePage(title: 'Test'));
  }
}
