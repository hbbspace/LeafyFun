import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/login.dart';
import 'package:leafyfun/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {

  // Load .env file
  await dotenv.load(fileName: ".env");
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
        home: LogInScreen(),
        // home: ScanPage()
        // home: SplashScreen());
        // home: LeafyQuiz());
        // home: ProfilePage());
        // home: HomePageScreen(
        //   token: '',
        // )
        // home: LeafyGarden());
        // home: CarouselDemo());
      ),
    );
  }
}
