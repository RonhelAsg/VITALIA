import 'package:flutter/material.dart';

import 'package:vitalia/screens/auth/login_patient.dart';
import 'package:vitalia/screens/auth/login_center.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qui êtes-vous ?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Bouton Patient → Login Patient
            _simpleButton(
              text: "Patient",
              icon: Icons.person,
              color: Colors.blue,
              onTap: () => _goToLoginScreen(context, const LoginPatientScreen()),
            ),

            const SizedBox(height: 20),

            // Bouton Centre → Login Centre
            _simpleButton(
              text: "Centre de santé",
              icon: Icons.local_hospital,
              color: Colors.green,
              onTap: () => _goToLoginScreen(context, const LoginCenterScreen()),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer un bouton simple
  Widget _simpleButton({
    required String text,
    required IconData icon,
    required Color color,
    required Function() onTap,
  }) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          //primary: color,
          padding: const EdgeInsets.all(15),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  // Navigation vers les écrans de login
  void _goToLoginScreen(BuildContext context, Widget loginScreen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => loginScreen),
    );
  }
}