import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/editProfile.dart';
// import 'package:leafyfun/Screens/questionPage.dart';
// import 'package:leafyfun/Screens/scanDetail.dart';
import 'package:leafyfun/providers/auth_provider.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:leafyfun/Screens/login.dart';
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
    // File dummy yang diakses dari asset (pastikan ada di project).

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LeafyFun',
        theme: ThemeData(primarySwatch: Colors.green),
        // home: SplashScreen(),
        home: EditProfilePage(),
      ),
    );
  }
}
