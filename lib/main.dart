import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/splashscreen.dart';

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
        home: const SplashScreen() // Splash Screen
        );
  }
}

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   MainScreenState createState() => MainScreenState();
// }

// class MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//   final List<Widget> _pages = [];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: IndexedStack(
//           index: _currentIndex,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed, // Removes scaling effect
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           backgroundColor: Colors.white, // Background color
//           selectedItemColor: Colors.black, // Color for selected item
//           unselectedItemColor: Colors.grey, // Color for unselected item
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.history), label: 'History'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.qr_code_scanner_outlined), label: 'Pay'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.message_rounded), label: 'Inbox'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
//           ],
//         ),
//       ),
//     );
//   }
// }