import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
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
        theme: ThemeData(primarySwatch: Colors.green),
        // home: Article1());
        // home: SplashScreen());
        // home: LeafyQuiz());
        home: HomePageScreen());
    // home: MyHomePage(title: 'Test'));
  }
}
