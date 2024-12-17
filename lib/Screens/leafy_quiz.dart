import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/homepage.dart';
import 'package:leafyfun/Screens/leafy_garden.dart';
import 'package:leafyfun/Screens/profile.dart';
import 'package:leafyfun/Screens/scan_page.dart';
import 'package:leafyfun/Widgets/floating_navbar.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/finished_quiz.dart';
import 'package:leafyfun/widgets/quiz_slider.dart';
import 'package:leafyfun/widgets/topbar_quiz.dart';
import 'package:leafyfun/widgets/searchbar.dart';
import 'package:leafyfun/Screens/question_page.dart';
import 'package:provider/provider.dart';

class LeafyQuiz extends StatefulWidget {
  const LeafyQuiz({super.key});

  @override
  _LeafyQuizState createState() => _LeafyQuizState();
}

class _LeafyQuizState extends State<LeafyQuiz> {
  int _selectedIndex = 1;
  bool _isDataInitialized = false;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> userPlants = []; // List to store user-owned plants
  List<dynamic> _filteredQuizItems =
      []; // Filtered quiz items based on user's plants

  final List<String> staticImages = [
    'assets/images/apple_plants.jpg',
    'assets/images/apple_plants.jpg',
    'assets/images/cherry_plants.jpg',
    'assets/images/grape_plants.jpg',
    'assets/images/strawberry_plants.jpg',
    'assets/images/tomato_plants.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isDataInitialized) {
      _initializeData();
    }
  }

  Future<void> _initializeData() async {
    if (_isDataInitialized) return;
    _isDataInitialized = true;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserInfo();
    final userId = userProvider.userId;

    if (userId != null) {
      await userProvider.checkUserPlant(userId);

      setState(() {
        userPlants = userProvider.userPlant
            .map((plant) => {
                  'plant_id': plant['plant_id'], // Ambil plant_id
                  'common_name': plant['common_name'] as String,
                  'quiz_score': plant['quiz_score'],
                })
            .toList();

        _filteredQuizItems = List.from(userPlants); // Initialize filtered items
        debugPrint(userPlants.toString()); // Print userPlants for debugging
      });
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePageScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LeafyQuiz()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ScanPage()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LeafyGarden()));
        break;
      case 4:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName =
        Provider.of<UserProvider>(context).userName ?? 'Loading...';

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(10, 66, 63, 1),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Image.asset(
                'assets/images/BackgroundLeafyQuiz.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  TopbarQuiz(
                    greeting: "Welcome to Leafy Quiz,",
                    userName: userName,
                    profileImagePath: 'assets/images/profilePicture.png',
                  ),
                  const SizedBox(height: 10),
                  SearchBarQuiz(
                    controller: _searchController,
                    hintText: "Search quizzes...",
                    onChanged: (query) {
                      setState(() {
                        if (query.isEmpty) {
                          _filteredQuizItems = List.from(userPlants);
                        } else {
                          _filteredQuizItems = userPlants
                              .where((item) => item['common_name']
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 30, bottom: 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView(
                padding: const EdgeInsets.only(left: 2, right: 2),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Text(
                      'All Quizzes',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: QuizSlider(),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Text(
                      'Select Your Unlocked Quiz',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._filteredQuizItems.map((quiz) {
                    return GestureDetector(
                      onTap: () {
                        final plantId =
                            quiz['plant_id']; // Ambil plant_id dari Map
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                QuestionPage(plantId: plantId),
                          ),
                        );
                      },
                      child: FinishedQuiz(
                        plantName: quiz['common_name'],
                        plantImage: staticImages[quiz['plant_id']],
                        quizDescription:
                            'Your Last Score is ${quiz['quiz_score']}/100.',
                      ),
                    );
                  }),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            right: 20,
            child: FloatingNavigationButtonBar(
              currentIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
