import 'package:flutter/material.dart';
import 'package:leafyfun/widgets/arrowBack_button.dart';

class ArticleWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final List<Section> sections;

  const ArticleWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arrow Back Button
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                child: ArrowBackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconPath: 'assets/images/ArrowLeftBlack.png',
                  borderColor: const Color.fromARGB(255, 130, 130, 130),
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Article Title
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Image Illustration
                        Image.asset(
                          imagePath,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),

                        const SizedBox(height: 20),

                        // Article Sections
                        ...sections.map((section) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Title
                                Text(
                                  section.subtitle,
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Section Content
                                Text(
                                  section.content,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),

                                const SizedBox(height: 20),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Section {
  final String subtitle;
  final String content;

  Section({required this.subtitle, required this.content});
}
