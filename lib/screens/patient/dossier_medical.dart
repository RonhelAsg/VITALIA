import 'package:flutter/material.dart';

class DossierMedicalScreen extends StatefulWidget {
  const DossierMedicalScreen({Key? key}) : super(key: key);

  @override
  State<DossierMedicalScreen> createState() => _DossierMedicalScreenState();
}

class _DossierMedicalScreenState extends State<DossierMedicalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Dossier Médical'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.info), text: 'Infos'),
            Tab(icon: Icon(Icons.history), text: 'Historique'),
            Tab(icon: Icon(Icons.medication), text: 'Traitements'),
            Tab(icon: Icon(Icons.folder), text: 'Documents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInfoGenerales(),
          _buildHistorique(),
          _buildTraitements(),
          _buildDocuments(),
        ],
      ),
    );
  }

  Widget _buildInfoGenerales() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Carte informations personnelles
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informations Personnelles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Nom complet', 'Jean DUPONT'),
                _buildInfoRow('Date de naissance', '15 mars 1985'),
                _buildInfoRow('Sexe', 'Masculin'),
                _buildInfoRow('Groupe sanguin', 'O+'),
                _buildInfoRow('Taille', '175 cm'),
                _buildInfoRow('Poids', '78 kg'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Carte contact d'urgence
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact d\'Urgence',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Nom', 'Marie DUPONT'),
                _buildInfoRow('Relation', 'Épouse'),
                _buildInfoRow('Téléphone', '+33 6 98 76 54 32'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Carte allergies
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Allergies Connues',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _showAddAllergyDialog(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildAllergyChip('Pénicilline', Colors.red),
                const SizedBox(height: 8),
                _buildAllergyChip('Arachides', Colors.orange),
                const SizedBox(height: 8),
                _buildAllergyChip('Pollen', Colors.yellow.shade700),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorique() {
    final consultations = [
      {
        'date': '2024-09-01',
        'medecin': 'Dr. Martin LEROY',
        'specialite': 'Cardiologue',
        'centre': 'Hôpital Central',
        'diagnostic': 'Hypertension artérielle légère',
        'notes': 'Surveillance tension artérielle, activité physique recommandée'
      },
      {
        'date': '2024-08-15',
        'medecin': 'Dr. Sophie BERNARD',
        'specialite': 'Médecin généraliste',
        'centre': 'Cabinet Médical Saint-Pierre',
        'diagnostic': 'Consultation de routine',
        'notes': 'Bilan sanguin à effectuer dans 3 mois'
      },
      {
        'date': '2024-07-20',
        'medecin': 'Dr. Paul MARTIN',
        'specialite': 'Endocrinologue',
        'centre': 'Clinique des Spécialités',
        'diagnostic': 'Suivi diabète type 2',
        'notes': 'Glycémie stable, continuer le traitement actuel'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: consultations.length,
      itemBuilder: (context, index) {
        final consultation = consultations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(
                consultation['date']!.split('-')[2],
                style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              consultation['medecin']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${consultation['specialite']} - ${consultation['centre']}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnostic:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                    ),
                    Text(consultation['diagnostic']!),
                    const SizedBox(height: 8),
                    Text(
                      'Notes:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                    ),
                    Text(consultation['notes']!),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTraitements() {
    final traitements = [
      {
        'medicament': 'Amlodipine',
        'dosage': '10mg',
        'frequence': '1 fois par jour',
        'debut': '2024-09-01',
        'fin': 'Traitement continu',
        'prescripteur': 'Dr. Martin LEROY',
        'actif': true,
      },
      {
        'medicament': 'Metformine',
        'dosage': '500mg',
        'frequence': '2 fois par jour',
        'debut': '2024-07-20',
        'fin': 'Traitement continu',
        'prescripteur': 'Dr. Paul MARTIN',
        'actif': true,
      },
      {
        'medicament': 'Paracétamol',
        'dosage': '1g',
        'frequence': 'Si nécessaire',
        'debut': '2024-08-15',
        'fin': '2024-08-25',
        'prescripteur': 'Dr. Sophie BERNARD',
        'actif': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: traitements.length,
      itemBuilder: (context, index) {
        final traitement = traitements[index];
        final isActif = traitement['actif'] as bool;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActif ? Colors.green.shade100 : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.medication,
                color: isActif ? Colors.green : Colors.grey,
              ),
            ),
            title: Text(
              '${traitement['medicament']} ${traitement['dosage']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActif ? Colors.black : Colors.grey,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${traitement['frequence']}'),
                Text('Prescrit par: ${traitement['prescripteur']}'),
                Text('Période: ${traitement['debut']} → ${traitement['fin']}'),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isActif ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isActif ? 'ACTIF' : 'TERMINÉ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  Widget _buildDocuments() {
    final documents = [
      {
        'titre': 'Résultats de laboratoire',
        'date': '2024-09-01',
        'type': 'Analyses sanguines',
        'taille': '1.2 MB',
        'icon': Icons.analytics,
      },
      {
        'titre': 'Radiographie thoracique',
        'date': '2024-08-15',
        'type': 'Imagerie médicale',
        'taille': '3.5 MB',
        'icon': Icons.medical_information,
      },
      {
        'titre': 'Ordonnance Dr. Martin',
        'date': '2024-09-01',
        'type': 'Prescription',
        'taille': '0.8 MB',
        'icon': Icons.description,
      },
      {
        'titre': 'Compte-rendu consultation',
        'date': '2024-07-20',
        'type': 'Rapport médical',
        'taille': '1.1 MB',
        'icon': Icons.article,
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mes Documents',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () => _showUploadDialog(),
                icon: const Icon(Icons.upload),
                label: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(
                      document['icon'] as IconData,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  title: Text(
                    document['titre'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${document['type']} - ${document['date']}\nTaille: ${document['taille']}'),
                  trailing: PopupMenuButton<String>(
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'view',
                        child: Row(
                          children: [
                            Icon(Icons.visibility, size: 20),
                            SizedBox(width: 8),
                            Text('Voir'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'download',
                        child: Row(
                          children: [
                            Icon(Icons.download, size: 20),
                            SizedBox(width: 8),
                            Text('Télécharger'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share, size: 20),
                            SizedBox(width: 8),
                            Text('Partager'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      print('Action $value sur ${document['titre']}');
                    },
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergyChip(String allergie, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            allergie,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showAddAllergyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter une Allergie'),
          content: const TextField(
            decoration: InputDecoration(
              labelText: 'Nom de l\'allergie',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('Allergie ajoutée');
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un Document'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Prendre une photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  print('Ouvrir appareil photo');
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choisir dans la galerie'),
                onTap: () {
                  Navigator.of(context).pop();
                  print('Ouvrir galerie');
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Sélectionner un fichier'),
                onTap: () {
                  Navigator.of(context).pop();
                  print('Ouvrir gestionnaire de fichiers');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
