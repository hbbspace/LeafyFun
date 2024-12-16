import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leafyfun/providers/user_provider.dart';
import 'package:leafyfun/widgets/option_tile_widget.dart';
import 'package:provider/provider.dart';

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['question_text'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correct_answer_index'],
    );
  }
}

class QuestionPage extends StatefulWidget {
  final int plantId;

  const QuestionPage({super.key, required this.plantId});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Question> questions = [];
  List<int?> selectedAnswers = [];
  int currentQuestionIndex = 0;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    loadUserIdAndFetchQuestions();
  }

  void moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Jika sudah di akhir pertanyaan, tampilkan dialog submit
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Submit Answers",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            "Are you sure you want to submit your answers?",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(10, 66, 63, 1),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                handleSubmit();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Color.fromRGBO(10, 66, 63, 1), // Border hijau
                ),
                backgroundColor:
                    Color.fromRGBO(10, 66, 63, 1), // Background hijau
              ),
              child: Text(
                "Submit",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white, // Teks putih
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void moveToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  Future<void> loadUserIdAndFetchQuestions() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserInfo();
    final userId = userProvider.userId;

    if (userId == null) {
      debugPrint("User ID is null. Redirecting or showing error.");
      return;
    }

    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['ENDPOINT_URL']}/quizzes/${widget.plantId}'),
        headers: {
          'ngrok-skip-browser-warning': 'true',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          questions = data.map((json) => Question.fromJson(json)).toList();
          selectedAnswers = List<int?>.filled(questions.length, null);
        });
      } else {
        debugPrint(
            'Failed to load questions. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error fetching questions: $e");
    }
  }

  void handleSubmit() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserInfo();
    final userId = userProvider.userId;

    debugPrint("Selected Answers: ${jsonEncode(selectedAnswers)}");

    setState(() {
      isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            '${dotenv.env['ENDPOINT_URL']}/submit-quiz/$userId/${widget.plantId}'),
        headers: {
          'ngrok-skip-browser-warning': 'true',
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode(selectedAnswers),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Quiz Completed',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            content: Text('Your score is: ${responseData['score']}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        debugPrint(
            'Failed to submit quiz. Status Code: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Error'),
            content: Text('Failed to submit the quiz. Please try again.'),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error submitting quiz: $e");
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('Error'),
          content:
              Text('An unexpected error occurred. Please try again later.'),
        ),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/images/ArrowLeftBlack.png', // Path ke gambar
                width: 24, // Lebar gambar
                height: 24, // Tinggi gambar
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Leafy Quiz',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / questions.length,
                    backgroundColor: Color.fromRGBO(149, 164, 164, 1),
                    color: Color.fromRGBO(10, 66, 63, 1),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "${currentQuestionIndex + 1}/${questions.length}",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20),

            Text(
              question.questionText,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
// Options
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAnswers[currentQuestionIndex] = index;
                      });
                    },
                    child: OptionTile(
                      text: question.options[index],
                      isSelected:
                          selectedAnswers[currentQuestionIndex] == index,
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: currentQuestionIndex > 0
                        ? moveToPreviousQuestion
                        : null,
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: currentQuestionIndex > 0
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: moveToNextQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
                    ),
                    child: Text(
                      currentQuestionIndex == questions.length - 1
                          ? 'Submit'
                          : 'Next Question',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
