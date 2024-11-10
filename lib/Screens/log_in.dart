import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _obscureText = true; // Menyembunyikan teks password secara default

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Mengubah kondisi tampilan password
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/Background_LogIn.jpg', // Ganti dengan path gambar background
              fit: BoxFit.cover,
            ),
          ),
          // login form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView(
                children: [
                  // Teks "Login" di sebelah kiri
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Kolom email dan password di tengah
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Username / Email',
                            labelStyle: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Kolom input password dengan ikon mata
                        TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontFamily: 'Poppins', fontSize: 13),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Teks Forgot Password
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              // Tambahkan navigasi atau aksi yang diinginkan
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tombol Login di tengah bawah
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Tambahkan navigasi atau fungsi login di sini
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 200,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  const Center(
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromRGBO(81, 89, 120, 1),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Tombol Login dengan Google
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Tambahkan navigasi atau fungsi login Google di sini
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 135,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(350),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/devicon_google.png', // Tambahkan ikon Google di sini
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Login with Google',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tombol Login dengan Apple
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Tambahkan navigasi atau fungsi login Apple di sini
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 140,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(350),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/devicon_apple.png', // Tambahkan ikon Apple di sini
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Login with Apple',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
