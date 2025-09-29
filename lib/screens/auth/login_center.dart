import 'package:flutter/material.dart';

class LoginCenterScreen extends StatefulWidget {
  const LoginCenterScreen({Key? key}) : super(key: key);

  @override
  State<LoginCenterScreen> createState() => _LoginCenterScreenState();
}

class _LoginCenterScreenState extends State<LoginCenterScreen> {
  final _idController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _sendOtpToCenter() {
    final vitaliaId = _idController.text.trim();
    final email = _emailController.text.trim();

    if (vitaliaId.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    print('Envoi OTP à $email pour ID $vitaliaId');
    // À COMPLÉTER AVEC ENVOI EMAIL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion Centre de Santé'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_vitalia.png',
              height: 100,
            ),
            const SizedBox(height: 30),

            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'ID VITALIA',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email du centre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                hintText: 'centre@exemple.com',
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _sendOtpToCenter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Recevoir le code par email',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}