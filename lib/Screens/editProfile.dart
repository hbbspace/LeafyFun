import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameControllerr = TextEditingController();
  TextEditingController _emailControllerr = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values (you can fetch these from a profile API or database)
    _usernameControllerr.text = "CurrentUsername";
    _emailControllerr.text = "user@example.com";
  }

  @override
  void dispose() {
    _usernameControllerr.dispose();
    _emailControllerr.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Process the data (save to database or API)
      String updatedUsername = _usernameControllerr.text;
      String updatedEmail = _emailControllerr.text;
      // You can add your saving logic here (API call, etc.)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.blue, // Customize AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Username TextField with custom style
              TextField(
                controller: _usernameControllerr,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors
                      .white, // Set background color to white for TextField
                ),
              ),
              const SizedBox(height: 15),
              // Email TextField with custom style
              TextField(
                controller: _emailControllerr,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors
                      .white, // Set background color to white for TextField
                ),
              ),
              const SizedBox(height: 20),
              // Save Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set button color
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 16),
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
