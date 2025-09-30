import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Méthode de déconnexion
  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      // La navigation sera gérée par l'authentification
      print('Déconnexion réussie');
    } catch (e) {
      print('Erreur de déconnexion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Espace Patient'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // Menu déroulant avec déconnexion
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, size: 20),
                    SizedBox(width: 8),
                    Text('Mon profil complet'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 20),
                    SizedBox(width: 8),
                    Text('Paramètres'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Déconnexion', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  print('Navigation vers profil complet');
                  break;
                case 'settings':
                  print('Navigation vers paramètres');
                  break;
                case 'logout':
                  _showLogoutConfirmation();
                  break;
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // CARTE PROFIL
          _buildProfileCard(),
          const SizedBox(height: 20),

          // PROCHAIN RDV
          _buildNextAppointment(),
          const SizedBox(height: 20),

          // ACCÈS RAPIDE
          _buildQuickActions(),
          const SizedBox(height: 20),

          // DERNIÈRES CONSULTATIONS
          _buildRecentConsultations(),
        ],
      ),
    );
  }

  // Dialogue de confirmation pour la déconnexion
  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Déconnexion'),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                _signOut(); // Effectue la déconnexion
              },
              child: const Text(
                'Déconnexion',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Carte de profil
  Widget _buildProfileCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Photo de profil
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, size: 30, color: Colors.blue),
            ),
            const SizedBox(width: 16),

            // Infos patient
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jean Dupont',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID VITALIA: PAT-0001',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Contact urgence: +33698765432',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Prochain rendez-vous
  Widget _buildNextAppointment() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prochain Rendez-vous',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calendar_today, color: Colors.green),
              ),
              title: const Text('Consultation de routine'),
              subtitle: const Text('Dr. Martin - Hôpital Central'),
              trailing: const Text('15 Sept\n14:30',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // Bouton d'action pour le RDV
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  print('Voir les détails du RDV');
                },
                child: const Text('Voir les détails'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Actions rapides
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accès Rapide',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.medical_services,
                label: 'Dossier Médical',
                color: Colors.blue,
                onTap: () {
                  print('Navigation vers dossier médical');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                icon: Icons.calendar_today,
                label: 'Prendre RDV',
                color: Colors.green,
                onTap: () {
                  print('Navigation vers prise de RDV');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.history,
                label: 'Historique',
                color: Colors.orange,
                onTap: () {
                  print('Navigation vers historique');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                icon: Icons.local_hospital,
                label: 'Centres',
                color: Colors.purple,
                onTap: () {
                  print('Navigation vers centres de santé');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Bouton action
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dernières consultations
  Widget _buildRecentConsultations() {
    final consultations = [
      {
        'date': '2024-09-01',
        'doctor': 'Dr. Martin',
        'diagnosis': 'Hypertension artérielle',
        'prescription': 'Amlodipine 10mg'
      },
      {
        'date': '2024-08-15',
        'doctor': 'Dr. Dupont',
        'diagnosis': 'Consultation de routine',
        'prescription': 'Aucun'
      },
      {
        'date': '2024-07-20',
        'doctor': 'Dr. Leroy',
        'diagnosis': 'Suivi diabète',
        'prescription': 'Metformine 500mg'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Dernières Consultations',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                print('Voir tout l\'historique');
              },
              child: const Text('Voir tout'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...consultations.map((consultation) => _buildConsultationCard(consultation)),
      ],
    );
  }

  // Carte consultation
  Widget _buildConsultationCard(Map<String, String> consultation) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  consultation['date']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  consultation['doctor']!,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Diagnostic: ${consultation['diagnosis']!}'),
            const SizedBox(height: 4),
            Text('Traitement: ${consultation['prescription']!}'),
          ],
        ),
      ),
    );
  }
}