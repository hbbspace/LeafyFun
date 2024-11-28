import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage1.dart';

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
        // home: LogInScreen());
        // home: ScanPage());
        // home: SplashScreen());
        // home: LeafyQuiz());
        // home: ProfilePage());
        // home: HomePageScreen());
        // home: LeafyGarden());
        home: CarouselDemo());
  }
}
