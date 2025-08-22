import 'package:flutter/material.dart';

class LoginPatientScreen extends StatelessWidget {
  const LoginPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion Admin')),
      body: const Center(
        child: Text('Écran de connexion admin'),
      ),
    );
  }
}