import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/option_tile_widget.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestionIndex = 0; // Indeks pertanyaan saat ini

  // Daftar jawaban yang dipilih oleh pengguna
  List<int?> selectedAnswers = []; // Nilai null jika belum dijawab

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

  @override
  void initState() {
    super.initState();
    // Inisialisasi daftar jawaban dengan null
    selectedAnswers = List<int?>.filled(questions.length, null);
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
                _submitAnswers();
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

  void _submitAnswers() {
    // Proses pengiriman jawaban ke server atau database
    print("Submitted Answers: $selectedAnswers");
    // TODO: Tambahkan logika untuk mengirim data ke server/database
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white, // Tambahkan ini untuk warna latar body
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

            // Progress bar
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
            // Question text
            Text(
              currentQuestion.question,
              style: TextStyle(
                fontFamily: 'Poppins',
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
                        selectedAnswers[currentQuestionIndex] = index;
                      });
                    },
                    child: OptionTile(
                      text: currentQuestion.options[index],
                      isSelected:
                          selectedAnswers[currentQuestionIndex] == index,
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
                      side:
                          BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                      padding: EdgeInsets.symmetric(vertical: 16),
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
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: moveToNextQuestion,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Color.fromRGBO(10, 66, 63, 1)),
                    child: Text(
                      currentQuestionIndex == questions.length - 1
                          ? 'Submit'
                          : 'Next Question',
                      style: TextStyle(
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
