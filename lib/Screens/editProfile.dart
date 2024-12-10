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
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _usernameControllerr,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailControllerr,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditProfilePage(),
  ));
}
