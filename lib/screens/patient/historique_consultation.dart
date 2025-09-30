import 'package:flutter/material.dart';

class HistoriqueConsultationsScreen extends StatelessWidget {
  const HistoriqueConsultationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consultations = [
      {
        'date': '15 Septembre 2024',
        'medecin': 'Dr. Martin - Cardiologue',
        'diagnostic': 'Hypertension artérielle stabilisée',
        'prescription': 'Amlodipine 10mg - 1 comprimé par jour'
      },
      {
        'date': '10 Août 2024',
        'medecin': 'Dr. Leroy - Généraliste',
        'diagnostic': 'Consultation de routine',
        'prescription': 'Bilan sanguin à réaliser'
      },
      {
        'date': '25 Juin 2024',
        'medecin': 'Dr. Petit - Dermatologue',
        'diagnostic': 'Eczéma modéré',
        'prescription': 'Crème hydratante 2x par jour'
      },
      {
        'date': '12 Mai 2024',
        'medecin': 'Dr. Martin - Cardiologue',
        'diagnostic': 'Première consultation hypertension',
        'prescription': 'Amlodipine 5mg - Surveillance tension'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des Consultations'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: consultations.length,
        itemBuilder: (context, index) {
          final consultation = consultations[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        consultation['date']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          consultation['medecin']!.split(' - ')[1],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    consultation['medecin']!,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Diagnostic:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(consultation['diagnostic']!),
                  const SizedBox(height: 8),
                  const Text(
                    'Traitement:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(consultation['prescription']!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}