import 'package:flutter/material.dart';

class GestionCentresScreen extends StatefulWidget {
  const GestionCentresScreen({Key? key}) : super(key: key);

  @override
  State<GestionCentresScreen> createState() => _GestionCentresScreenState();
}

class _GestionCentresScreenState extends State<GestionCentresScreen> {
  String _filtreStatut = 'tous';
  final _rechercheController = TextEditingController();

  final List<Map<String, dynamic>> _centres = [
    {
      'id': 'CENT-001',
      'nom': 'Clinique Paris Centre',
      'ville': 'Paris',
      'specialites': ['Cardiologie', 'Médecine générale'],
      'statut': 'actif',
      'email': 'contact@clinique-paris.fr',
      'telephone': '+33 1 45 67 89 10',
      'dateInscription': '2024-08-20',
      'patients': 156,
      'consultationsMois': 423,
    },
    {
      'id': 'CENT-023',
      'nom': 'Hôpital Saint-Louis',
      'ville': 'Paris',
      'specialites': ['Urgences', 'Chirurgie'],
      'statut': 'en_attente',
      'email': 'admin@hopital-saintlouis.fr',
      'telephone': '+33 1 34 56 78 90',
      'dateInscription': '2024-10-03',
      'patients': 0,
      'consultationsMois': 0,
    },
    {
      'id': 'CENT-045',
      'nom': 'Centre Médical Lyon Sud',
      'ville': 'Lyon',
      'specialites': ['Pédiatrie', 'Radiologie'],
      'statut': 'actif',
      'email': 'contact@lyonmedical.fr',
      'telephone': '+33 4 78 56 34 12',
      'dateInscription': '2024-09-10',
      'patients': 89,
      'consultationsMois': 234,
    },
    {
      'id': 'CENT-067',
      'nom': 'Polyclinique Marseille',
      'ville': 'Marseille',
      'specialites': ['Dermatologie', 'Ophtalmologie'],
      'statut': 'inactif',
      'email': 'info@poly-marseille.fr',
      'telephone': '+33 4 91 23 45 67',
      'dateInscription': '2024-07-15',
      'patients': 45,
      'consultationsMois': 0,
    },
  ];

  List<Map<String, dynamic>> get _centresFiltres {
    return _centres.where((centre) {
      final matchStatut = _filtreStatut == 'tous' || centre['statut'] == _filtreStatut;
      final matchRecherche = _rechercheController.text.isEmpty ||
          centre['nom'].toString().toLowerCase().contains(_rechercheController.text.toLowerCase()) ||
          centre['ville'].toString().toLowerCase().contains(_rechercheController.text.toLowerCase()) ||
          centre['id'].toString().toLowerCase().contains(_rechercheController.text.toLowerCase());

      return matchStatut && matchRecherche;
    }).toList();
  }

  void _changerStatut(String centreId, String nouveauStatut) {
    setState(() {
      final centre = _centres.firstWhere((c) => c['id'] == centreId);
      centre['statut'] = nouveauStatut;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Statut de $centreId mis à jour: $nouveauStatut')),
    );
  }

  void _showDetails(BuildContext context, Map<String, dynamic> centre) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_hospital, size: 40, color: Colors.green),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        centre['nom'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(centre['ville'], style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                _buildStatutChip(centre['statut']),
              ],
            ),
            SizedBox(height: 16),
            _buildDetailRow('ID Centre', centre['id']),
            _buildDetailRow('Email', centre['email']),
            _buildDetailRow('Téléphone', centre['telephone']),
            _buildDetailRow('Date d\'inscription', centre['dateInscription']),
            SizedBox(height: 8),
            Text('Spécialités:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: (centre['specialites'] as List<String>)
                  .map((spec) => Chip(label: Text(spec), visualDensity: VisualDensity.compact))
                  .toList(),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                _buildStatCard('${centre['patients']}', 'Patients', Colors.blue),
                SizedBox(width: 12),
                _buildStatCard('${centre['consultationsMois']}', 'Consultations/mois', Colors.orange),
              ],
            ),
            SizedBox(height: 16),
            if (centre['statut'] == 'en_attente') ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _changerStatut(centre['id'], 'actif'),
                      child: Text('Approuver'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _changerStatut(centre['id'], 'inactif'),
                      child: Text('Refuser'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatutChip(String statut) {
    Color color;
    String text;

    switch (statut) {
      case 'actif':
        color = Colors.green;
        text = 'Actif';
        break;
      case 'inactif':
        color = Colors.orange;
        text = 'Inactif';
        break;
      case 'en_attente':
        color = Colors.blue;
        text = 'En attente';
        break;
      default:
        color = Colors.grey;
        text = statut;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Centres de Santé'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // FILTRES ET RECHERCHE
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Barre de recherche
                TextField(
                  controller: _rechercheController,
                  decoration: InputDecoration(
                    labelText: 'Rechercher un centre...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _rechercheController.clear();
                        setState(() {});
                      },
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 12),
                // Filtre statut
                DropdownButtonFormField<String>(
                  value: _filtreStatut,
                  items: const [
                    DropdownMenuItem(value: 'tous', child: Text('Tous les statuts')),
                    DropdownMenuItem(value: 'actif', child: Text('Actifs')),
                    DropdownMenuItem(value: 'inactif', child: Text('Inactifs')),
                    DropdownMenuItem(value: 'en_attente', child: Text('En attente')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _filtreStatut = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Filtrer par statut',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          // STATISTIQUES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildGlobalStat('Total', _centresFiltres.length, Colors.grey),
                SizedBox(width: 12),
                _buildGlobalStat('Actifs', _centresFiltres.where((c) => c['statut'] == 'actif').length, Colors.green),
                SizedBox(width: 12),
                _buildGlobalStat('En attente', _centresFiltres.where((c) => c['statut'] == 'en_attente').length, Colors.blue),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // LISTE DES CENTRES
          Expanded(
            child: ListView.builder(
              itemCount: _centresFiltres.length,
              itemBuilder: (context, index) {
                final centre = _centresFiltres[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: Icon(Icons.local_hospital, size: 40, color: Colors.green),
                    title: Text(
                      centre['nom'],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(centre['ville']),
                        SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          children: (centre['specialites'] as List<String>)
                              .take(2)
                              .map((spec) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              spec,
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ))
                              .toList(),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            _buildStatutChip(centre['statut']),
                            SizedBox(width: 8),
                            Text(
                              centre['id'],
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () => _showDetails(context, centre),
                    ),
                    onTap: () => _showDetails(context, centre),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalStat(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}