import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Initialise Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Lance l'application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon App Médicale',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPatient(), // Va directement à l'écran de login
    );
  }
}

class LoginPatient extends StatelessWidget {
  const LoginPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion Patient'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            // Vous ajouterez ici vos champs de connexion plus tard
            Text('Écran de connexion patient'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}