import 'package:flutter/material.dart';
import 'package:leafyfun/Screens/login.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background_LogIn.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Button kembali atau navigasi ke halaman Login
          Positioned(
            top: 85,
            left: 20,
            child: GestureDetector(
              onTap: () {
                // Navigasi ke halaman Login atau kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Container luar sebagai "stroke"
                  Container(
                    width:
                        46, // Lebar dan tinggi lebih besar dari gambar untuk "stroke"
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Warna latar belakang stroke
                      borderRadius: BorderRadius.circular(10), // Border rounded
                      border: Border.all(
                        color: Colors.grey, // Warna "stroke"
                        width: 1.5, // Ketebalan "stroke"
                      ),
                    ),
                  ),
                  // Container dalam berisi gambar icon
                  Container(
                    width: 30, // Lebar dan tinggi sesuai dengan ukuran gambar
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15), // Border rounded gambar
                    ),
                    child: Image.asset(
                      'assets/images/arrow-left.png', // Path gambar icon custom
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Teks "Forgot Password"
                  Text(
                    'New \nPassword',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter your new password',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),

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
              height: MediaQuery.of(context).size.height * 0.35,
              child: ListView(
                children: const [
                  HeaderText(),
                  SizedBox(height: 20),
                  NewPasswordForm(),
                  SizedBox(height: 30),
                  NewPasswordButton(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        'New Password',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key});

  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  // Variabel untuk mengontrol visibilitas masing-masing TextField
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Fungsi toggle untuk TextField pertama
  void _togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  // Fungsi toggle untuk TextField kedua
  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        TextField(
          obscureText:
              _obscureText1, // Menggunakan variabel untuk TextField pertama
          decoration: InputDecoration(
            labelText: 'New Password',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText1 ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed:
                  _togglePasswordVisibility1, // Menggunakan toggle pertama
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          obscureText:
              _obscureText2, // Menggunakan variabel untuk TextField kedua
          decoration: InputDecoration(
            labelText: 'Repeat Password',
            labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText2 ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _togglePasswordVisibility2, // Menggunakan toggle kedua
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class NewPasswordButton extends StatelessWidget {
  const NewPasswordButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Add navigation or NewPassword functionality here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogInScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(10, 66, 63, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
