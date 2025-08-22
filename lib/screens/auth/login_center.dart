import 'package:flutter/material.dart';

class LoginCenterScreen extends StatelessWidget {
  const LoginCenterScreen({Key? key}) : super(key: key);

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