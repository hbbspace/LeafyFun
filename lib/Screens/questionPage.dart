import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestionIndex = 0; // Indeks pertanyaan saat ini
  int? selectedOptionIndex; // Indeks jawaban yang dipilih

  // Daftar pertanyaan
  final List<Question> questions = [
    Question(
      question: "What is the latin name for orange fruit?",
      options: ["Citrus sinensis", "Malus", "Lionel Messi", "Vitis"],
      correctAnswerIndex: 0,
    ),
    Question(
      question: "Which part of the plant absorbs water?",
      options: ["Roots", "Stem", "Leaves", "Flowers"],
      correctAnswerIndex: 0,
    ),
  ];

  void moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null; // Reset pilihan
      });
    } else {
      // Jika sudah di akhir pertanyaan
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Quiz Completed"),
          content: Text("You have completed all questions!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
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
        selectedOptionIndex = null; // Reset pilihan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progress bar
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / questions.length,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
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
            // Question text
            Text(
              currentQuestion.question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Options
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOptionIndex = index;
                      });
                    },
                    child: OptionTile(
                      text: currentQuestion.options[index],
                      isSelected: selectedOptionIndex == index,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: currentQuestionIndex > 0
                        ? moveToPreviousQuestion
                        : null, // Disabled jika di pertanyaan pertama
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Previous',
                      style: TextStyle(
                        color: currentQuestionIndex > 0
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: moveToNextQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Next Question'),
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

class OptionTile extends StatelessWidget {
  final String text;
  final bool isSelected;

  const OptionTile({super.key, required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[100] : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing:
              isSelected ? Icon(Icons.check_circle, color: Colors.green) : null,
        ),
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
