import 'package:flutter/material.dart';

class ProfilPatientScreen extends StatefulWidget {
  const ProfilPatientScreen({Key? key}) : super(key: key);

  @override
  State<ProfilPatientScreen> createState() => _ProfilPatientScreenState();
}

class _ProfilPatientScreenState extends State<ProfilPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              print('Édition du profil');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Photo de profil
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Informations personnelles
              const Text(
                'Informations Personnelles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: 'Jean Dupont',
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: '1990-05-15',
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: '+33612345678',
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: 'PAT-0001',
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'ID VITALIA',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
              ),

              const SizedBox(height: 30),

              // Informations médicales
              const Text(
                'Informations Médicales',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: 'A+',
                decoration: const InputDecoration(
                  labelText: 'Groupe sanguin',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.bloodtype),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: 'Pénicilline, Pollen',
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Allergies connues',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.warning),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: '+33698765432',
                decoration: const InputDecoration(
                  labelText: 'Contact d\'urgence',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.emergency),
                ),
              ),

              const SizedBox(height: 30),

              // Boutons d'action
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Profil sauvegardé');
                  }
                },
                child: const Text('Sauvegarder les modifications'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  print('Changer le mot de passe');
                },
                child: const Text('Changer le mot de passe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}