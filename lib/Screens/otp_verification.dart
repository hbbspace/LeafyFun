import 'package:flutter/material.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Email Verification'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'We sent a verification code to',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '***man03@gmail.com',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < _otpControllers.length; i++)
                    _buildOtpInput(index: i),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // TODO: Implement resend functionality
                },
                child: const Text('Didn\'t receive the code? Resend'),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement verification logic
                  }
                },
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInput({required int index}) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: _otpControllers[index],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          counterText: '',
        ),
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1 && index < _otpControllers.length - 1) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
