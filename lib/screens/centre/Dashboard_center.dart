import 'package:flutter/material.dart';
import 'package:vitalia/screens/centre/nouvelle_consultation.dart';
import 'package:vitalia/screens/centre/planning.dart';
import 'package:vitalia/screens/centre/dossiers_patients.dart';
import 'package:vitalia/screens/centre/parametres.dart';

class DashboardCenter extends StatelessWidget {
  const DashboardCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord - Centre'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte de bienvenue
            Card(
              color: Colors.green[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.local_hospital, size: 40, color: Colors.green),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hôpital Central',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'ID: CENT-0001',
                            style: TextStyle(
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Statistiques rapides
            const Text(
              'Aujourd\'hui',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('5', 'Rendez-vous', Icons.calendar_today, Colors.blue),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('3', 'Patients', Icons.people, Colors.green),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Actions rapides
            const Text(
              'Actions Rapides',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Nouvelle Consultation',
                    Icons.add,
                    Colors.blue,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NouvelleConsultationScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildActionButton(
                    'Voir Planning',
                    Icons.schedule,
                    Colors.orange,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PlanningCentreScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Dossiers Patients',
                    Icons.folder,
                    Colors.purple,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DossiersPatientsCentreScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildActionButton(
                    'Paramètres',
                    Icons.settings,
                    Colors.grey,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ParametresCentreScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Rendez-vous du jour
            const Text(
              'Rendez-vous à venir',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildAppointmentCard('Marie Martin', '09:00', 'Consultation générale'),
                  _buildAppointmentCard('Jean Dupont', '10:30', 'Suivi traitement'),
                  _buildAppointmentCard('Sophie Leroy', '14:00', 'Première visite'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Carte de statistique
  Widget _buildStatCard(String number, String label, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Bouton d'action
  Widget _buildActionButton(String text, IconData icon, Color color, VoidCallback onPressed) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Carte de rendez-vous
  Widget _buildAppointmentCard(String patientName, String time, String type) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: Text(
            patientName[0],
            style: const TextStyle(color: Colors.green),
          ),
        ),
        title: Text(patientName),
        subtitle: Text(type),
        trailing: Text(
          time,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}