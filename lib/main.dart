import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/leafyQuiz.dart';
import 'package:leafyfun/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'LeafyFun',
        theme: ThemeData(primarySwatch: Colors.green),
        home: LeafyQuiz(),
        // home: ScanPage());
        // home: SplashScreen());
        // home: LeafyQuiz());
        // home: ProfilePage());
        // home: HomePageScreen());
        // home: LeafyGarden());
        // home: CarouselDemo());
      ),
    );
  }
}
