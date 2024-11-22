import 'package:flutter/material.dart';

class LeafyQuiz extends StatefulWidget {
  const LeafyQuiz({super.key});

  @override
  _LeafyQuizState createState() => _LeafyQuizState();
}

class _LeafyQuizState extends State<LeafyQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background hijau
          Container(
            color: const Color.fromRGBO(10, 66, 63, 1), // Warna hijau
          ),

          // Gambar di bagian atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.6, // Setengah layar
              child: Image.asset(
                'assets/images/BackgroundLeafyQuiz.png', // Path gambar
                fit: BoxFit.cover,
              ),
            ),
          ),

          // TopBar di atas background
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              child: TopBarWidget(
                greeting: "Welcome to Leafy Quiz,",
                userName: "User123",
                profileImagePath: 'assets/images/profile_image.png',
              ),
            ),
          ),

          // Konten di atas gambar
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                height:
                    MediaQuery.of(context).size.height * 0.8, // Bagian bawah
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome to Leafy Quiz!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Test your knowledge about plants in a fun way!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Tombol mulai quiz
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuizPage(), // Halaman quiz
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          child: Text(
                            'Start Quiz',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Konten tambahan agar bisa di-scroll
                    const SizedBox(height: 50),
                    const Text(
                      'Why take this quiz?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This quiz helps you understand more about plants in an engaging and educational way. Dive into the world of flora and expand your knowledge!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black54,
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
  }
}

// Placeholder untuk halaman quiz
class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
        backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
      ),
      body: const Center(
        child: Text(
          'Quiz content goes here',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
        ),
      ),
    );
  }
}

// TopBarWidget (disesuaikan)
class TopBarWidget extends StatelessWidget {
  final String greeting;
  final String userName;
  final String profileImagePath;

  const TopBarWidget({
    super.key,
    required this.greeting,
    required this.userName,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kata sambutan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5), // Jarak antara teks dan gambar
                  Image.asset(
                    'assets/images/waving_hands.png',
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
          // Gambar profil bulat kecil
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(profileImagePath),
          ),
        ],
      ),
    );
  }
}
