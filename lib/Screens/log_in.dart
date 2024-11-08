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
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align to the left
                children: [
                  // Teks "Login" di sebelah kiri
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Login',
                      style: TextStyle(
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
                            labelText: 'Username/Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Kolom input password dengan ikon mata
                        TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
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
                        const SizedBox(height: 30),

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
                                color: Colors.black,
                                fontSize: 14,
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
                          horizontal:
                              100, // Ubah padding horizontal agar lebih pas
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
