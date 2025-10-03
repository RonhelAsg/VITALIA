import 'package:flutter/material.dart';

class ListeCentreSanteScreen extends StatelessWidget {
  const ListeCentreSanteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final centres = [
      {
        'nom': 'Centre de Santé de Dakar',
        'adresse': '123 Rue de la Paix, Dakar',
      },
      {
        'nom': 'Clinique Sainte-Marie',
        'adresse': '456 Avenue des Palmiers, Thiès',
      },
      {
        'nom': 'Hôpital Général de Saint-Louis',
        'adresse': '789 Boulevard du Fleuve, Saint-Louis',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centres de Santé'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: centres.length,
        itemBuilder: (context, index) {
          return CentreSanteItem(centre: centres[index]);
        },
      ),
    );
  }
}

class CentreSanteItem extends StatelessWidget {
  final Map<String, dynamic> centre;

  const CentreSanteItem({Key? key, required this.centre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  centre['nom'] ?? 'Nom non disponible', // Correction appliquée
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  centre['adresse'] ?? 'Adresse non disponible',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Action pour voir les détails du centre
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}