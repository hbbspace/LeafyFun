import 'package:flutter/material.dart';

class Article1 extends StatelessWidget {
  const Article1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Warna background untuk SafeArea
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol Arrow Back
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                child: ArrowBackButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigasi kembali
                  },
                  iconPath:
                      'assets/images/ArrowLeftBlack.png', // Path ikon custom
                  borderColor: const Color.fromARGB(
                      255, 130, 130, 130), // Warna stroke custom
                ),
              ),

              // Konten utama halaman
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white, // Background halaman putih
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Judul Artikel
                        const Text(
                          'Cara Mudah Menanam Jeruk di Rumah!',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Gambar Ilustrasi
                        Image.asset(
                          'assets/images/artikel1.png',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),

                        const SizedBox(height: 20),

                        // Teks Pendahuluan
                        Text(
                          'In design, typography conveys messages, evokes emotions, and enhances experiences.',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sub Judul 1
                        const Text(
                          'Breaking Away from Conventions',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Teks Isi Sub Judul 1
                        Text(
                          'Past norms shattered; designers now embrace diverse, captivating typefaces—hand-drawn scripts, geometric experiments—infusing designs with limitless personality and uniqueness.',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sub Judul 2
                        const Text(
                          'Custom and Variable Fonts',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Teks Isi Sub Judul 2
                        Text(
                          'Custom and variable fonts reshape typography. Tailored custom fonts define brand uniqueness and seamless cross-platform integration. Variable fonts go further, enabling real-time adjustments of weight, width, and more. This adaptability boosts readability and ensures device-consistent experiences.',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sub Judul 3
                        const Text(
                          'The Future of Typography',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Teks Isi Sub Judul 3
                        Text(
                          'As technology evolves, typographyaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa will continue to play a crucial role in design, pushing boundaries and redefining visual communication.',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
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

class ArrowBackButton extends StatelessWidget {
  final VoidCallback onPressed; // Fungsi fleksibel untuk navigasi atau aksi
  final String iconPath; // Path ke gambar icon
  final Color borderColor; // Warna border stroke

  const ArrowBackButton({
    super.key,
    required this.onPressed,
    this.iconPath = 'assets/images/arrow-left.png', // Path default
    this.borderColor = Colors.grey, // Warna default
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Container luar sebagai "stroke"
          Container(
            width:
                35, // Lebar dan tinggi lebih besar dari gambar untuk "stroke"
            height: 35,
            decoration: BoxDecoration(
              color: Colors.transparent, // Warna latar belakang stroke
              borderRadius: BorderRadius.circular(10), // Border rounded
              border: Border.all(
                color: borderColor, // Warna "stroke"
                width: 1, // Ketebalan "stroke"
              ),
            ),
          ),
          // Container dalam berisi gambar icon
          Container(
            width: 20, // Lebar dan tinggi sesuai dengan ukuran gambar
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // Border rounded gambar
            ),
            child: Image.asset(
              iconPath, // Path gambar icon custom
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
