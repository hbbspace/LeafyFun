import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leafyfun/providers/user_provider.dart';
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

  // Factory untuk parsing JSON
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

Future<void> loadUserIdAndFetchQuestions() async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  await userProvider.loadUserInfo();
  final userId = userProvider.userId;

  if (userId == null) {
    debugPrint("User ID is null. Redirecting or showing error.");
    return; // You may want to handle this case with a redirect or error UI.
  }

  fetchQuestions();
}

  Future<void> fetchQuestions() async {
  try {
    final response = await http.get(
        Uri.parse('${dotenv.env['ENDPOINT_URL']}/quizzes/${widget.plantId}'),
        headers: {
          'ngrok-skip-browser-warning':
              'true', // Menambahkan header ini untuk menghindari halaman warning
        },
      );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        questions = data.map((json) => Question.fromJson(json)).toList();
        selectedAnswers = List<int?>.filled(questions.length, null);
      });
    } else {
      debugPrint('Failed to load questions. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint("Error fetching questions: $e");
  }
}

  void handleSubmit() async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  await userProvider.loadUserInfo();
  final userId = userProvider.userId;

  // Debug untuk memastikan jawaban yang dipilih dikirim dengan benar
  debugPrint("Selected Answers: ${jsonEncode(selectedAnswers)}");

  setState(() {
    isSubmitting = true;
  });

  try {
    final response = await http.post(
      Uri.parse('${dotenv.env['ENDPOINT_URL']}/submit-quiz/$userId/${widget.plantId}'),
      headers: {
        'ngrok-skip-browser-warning': 'true',
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode(selectedAnswers), // Mengirim array jawaban langsung
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Tampilkan pesan dan skor
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Quiz Completed'),
          content: Text('Your score is: ${responseData['score']}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      debugPrint('Failed to submit quiz. Status Code: ${response.statusCode}');
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
        content: Text('An unexpected error occurred. Please try again later.'),
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
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}/${questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questions[currentQuestionIndex].questionText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...question.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              return RadioListTile<int>(
                value: index,
                groupValue: selectedAnswers[currentQuestionIndex],
                onChanged: (value) {
                  setState(() {
                    selectedAnswers[currentQuestionIndex] = value;
                  });
                },
                title: Text(option),
              );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentQuestionIndex > 0
                      ? () {
                          setState(() {
                            currentQuestionIndex--;
                          });
                        }
                      : null,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: currentQuestionIndex < questions.length - 1
                      ? () {
                          setState(() {
                            currentQuestionIndex++;
                          });
                        }
                      : handleSubmit,
                  child: Text(currentQuestionIndex < questions.length - 1
                      ? 'Next'
                      : 'Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
