import 'dart:io'; // Untuk menangani file
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafyfun/widgets/save_profile_button.dart'; // Paket untuk memilih gambar

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _profileImage; // Untuk menyimpan gambar profil

  @override
  void initState() {
    super.initState();
    _usernameController.text = "CurrentUsername";
    _emailController.text = "user@example.com";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      String updatedUsername = _usernameController.text;
      String updatedEmail = _emailController.text;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Updated')));
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Simpan file yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Arrow Back Button
            IconButton(
              icon: Image.asset(
                'assets/images/ArrowLeftBlack.png', // Path ke gambar
                width: 24, // Lebar gambar
                height: 24, // Tinggi gambar
              ),
              onPressed: () => Navigator.pop(context),
            ),

            // Centered Edit Profile Title
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Profile Picture
            Center(
              child: GestureDetector(
                onTap: _pickImage, // Pilih gambar saat diketuk
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!) // Gambar yang diunggah
                      : AssetImage('assets/images/profilePicture.png')
                          as ImageProvider, // Gambar default
                  child: _profileImage == null
                      ? Image.asset(
                          'assets/images/edit_foto.png', // Path ke gambar edit_foto.png
                          width: 40, // Atur ukuran gambar
                          height: 40,
                          fit: BoxFit.contain,
                        )
                      : null, // Tampilkan ikon edit hanya jika belum ada gambar profil
                ),
              ),
            ),
            SizedBox(height: 30),

            // Form Fields
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Username TextField
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Email TextField
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Save Button
                  SaveProfileButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
