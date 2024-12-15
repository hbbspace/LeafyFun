import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QuizSlider extends StatelessWidget {
  QuizSlider({super.key});

  final List<String> bannerImages = [
    'assets/images/quiz_apple.jpg',
    'assets/images/quiz_cherry.jpeg',
    'assets/images/quiz_tomato.jpg',
    'assets/images/quiz_grape.jpg',
    'assets/images/quiz_strawberry.jpeg',
  ];

  final List<String> bannerTitles = [
    'Apple',
    'Cherry',
    'Tomato',
    'Grape',
    'Strawberry',
  ];

  final List<Widget> targetPages = [
    QuestionPage(
      questions: [
        Question(
          question: "What is the color of an apple?",
          options: ["Red", "Blue", "Yellow", "Green"],
          correctAnswerIndex: 0,
        ),
        Question(
          question: "Which vitamin is commonly found in apples?",
          options: ["Vitamin C", "Vitamin A", "Vitamin D", "Vitamin B12"],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    QuestionPage(
      questions: [
        Question(
          question: "What is the latin name for cherry?",
          options: [
            "Prunus avium",
            "Citrus limon",
            "Fragaria vesca",
            "Vitis vinifera"
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          question: "Which country produces the most cherries?",
          options: ["Turkey", "USA", "China", "Spain"],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    QuestionPage(
      questions: [
        Question(
          question: "Is tomato a fruit or vegetable?",
          options: ["Fruit", "Vegetable", "Both", "None"],
          correctAnswerIndex: 0,
        ),
        Question(
          question: "What is the primary nutrient found in tomatoes?",
          options: ["Vitamin C", "Iron", "Protein", "Fiber"],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    QuestionPage(
      questions: [
        Question(
          question: "What is the latin name for grape?",
          options: [
            "Vitis vinifera",
            "Citrus sinensis",
            "Prunus domestica",
            "Malus domestica"
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          question: "What is the main use of grapes?",
          options: ["Wine making", "Oil extraction", "Medicine", "Decoration"],
          correctAnswerIndex: 0,
        ),
      ],
    ),
    QuestionPage(
      questions: [
        Question(
          question: "What is the color of ripe strawberries?",
          options: ["Red", "Green", "Yellow", "Purple"],
          correctAnswerIndex: 0,
        ),
        Question(
          question: "Which nutrient is abundant in strawberries?",
          options: ["Vitamin C", "Vitamin A", "Calcium", "Iron"],
          correctAnswerIndex: 0,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          initialPage: 0,
          autoPlay: true,
          viewportFraction: 0.8,
        ),
        items: List.generate(bannerImages.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => targetPages[index],
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(bannerImages[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: SizedBox(
                    width: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          // Shadow text
                          Text(
                            bannerTitles[index],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black, // Shadow color
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              shadows: [
                                Shadow(
                                  offset: Offset(1.0, 1.0), // X and Y offset
                                  blurRadius: 3.0, // Blur radius
                                  color: Colors.black, // Shadow color
                                ),
                              ],
                            ),
                          ),
                          // Foreground text
                          Text(
                            bannerTitles[index],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromRGBO(
                                  255, 255, 255, 1), // White color
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final List<Question> questions;

  const QuestionPage({required this.questions, super.key});

  @override
  Widget build(BuildContext context) {
    // Build the QuestionPage UI based on the provided list of questions.
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Center(
        child: Text("Build your question UI here"),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}
