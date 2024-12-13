import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/leafyGarden.dart';
import 'package:leafyfun/Screens/login.dart';
import 'package:leafyfun/Screens/splashscreen.dart';
import 'package:leafyfun/providers/auth_provider.dart';
import 'package:leafyfun/providers/plant_provider.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/login_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PlantProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LeafyFun',
        theme: ThemeData(primarySwatch: Colors.green),
        // home: SplashScreen(),
        home: HomePageScreen(),
      ),
    );
  }
}
