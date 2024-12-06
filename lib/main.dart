import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // Load .env file
  // await dotenv.load(fileName: ".env");
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
          debugShowCheckedModeBanner: false, // Hilangkan tulisan "Debug"
          title: 'LeafyFun',
          theme: ThemeData(primarySwatch: Colors.green),
          // home: SplashScreen(),
          home: HomePageScreen(
            token: '',
          )),
    );
  }
}
