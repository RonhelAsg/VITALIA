import 'package:flutter/material.dart';

class DossiersPatientsCentreScreen extends StatefulWidget {
  const DossiersPatientsCentreScreen({Key? key}) : super(key: key);

  @override
  State<DossiersPatientsCentreScreen> createState() => _DossiersPatientsCentreScreenState();
}

class _DossiersPatientsCentreScreenState extends State<DossiersPatientsCentreScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedFilter;

  final List<Map<String, dynamic>> _patients = [
    {
      'id': 'PAT-0001',
      'nom': 'Jean DUPONT',
      'age': 45,
      'sexe': 'M',
      'telephone': '+33 6 12 34 56 78',
      'derniere_visite': '2024-09-15',
      'prochaine_visite': '2024-10-15',
      'medecin_traitant': 'Dr. Martin LEROY',
      'statut': 'actif',
      'urgence': false,
      'allergies': ['Pénicilline', 'Arachides'],
      'pathologies': ['Hypertension', 'Diabète type 2'],
      'nb_consultations': 12,
    },
    {
      'id': 'PAT-0002',
      'nom': 'Marie MARTIN',
      'age': 32,
      'sexe': 'F',
      'telephone': '+33 6 98 76 54 32',
      'derniere_visite': '2024-09-20',
      'prochaine_visite': '2024-11-20',
      'medecin_traitant': 'Dr. Sophie BERNARD',
      'statut': 'actif',
      'urgence': false,
      'allergies': [],
      'pathologies': ['Asthme'],
      'nb_consultations': 8,
    },
    {
      'id': 'PAT-0003',
      'nom': 'Pierre LEROY',
      'age': 67,
      'sexe': 'M',
      'telephone': '+33 6 55 44 33 22',
      'derniere_visite': '2024-09-25',
      'prochaine_visite': '2024-10-05',
      'medecin_traitant': 'Dr. Martin LEROY',
      'statut': 'suivi_special',
      'urgence': true,
      'allergies': ['Iode'],
      'pathologies': ['Insuffisance cardiaque', 'Hypertension'],
      'nb_consultations': 25,
    },
    {
      'id': 'PAT-0004',
      'nom': 'Sophie DUBOIS',
      'age': 28,
      'sexe': 'F',
      'telephone': '+33 6 77 88 99 00',
      'derniere_visite': '2024-08-10',
      'prochaine_visite': null,
      'medecin_traitant': 'Dr. Sophie BERNARD',
      'statut': 'inactif',
      'urgence': false,
      'allergies': ['Lactose'],
      'pathologies': [],
      'nb_consultations': 3,
    },
  ];

  final List<String> _filtres = ['Tous', 'Actifs', 'Suivi spécial', 'Inactifs', 'Urgents'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedFilter = 'Tous';
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _patientsFiltres {
    var patients = _patients.where((patient) {
      // Filtre par recherche
      final matchesSearch = _searchQuery.isEmpty ||
          patient['nom'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          patient['id'].toString().toLowerCase().contains(_searchQuery.toLowerCase());

      // Filtre par statut
      bool matchesFilter = true;
      switch (_selectedFilter) {
        case 'Actifs':
          matchesFilter = patient['statut'] == 'actif';
          break;
        case 'Suivi spécial':
          matchesFilter = patient['statut'] == 'suivi_special';
          break;
        case 'Inactifs':
          matchesFilter = patient['statut'] == 'inactif';
          break;
        case 'Urgents':
          matchesFilter = patient['urgence'] == true;
          break;
        case 'Tous':
        default:
          matchesFilter = true;
      }

      return matchesSearch && matchesFilter;
    }).toList();

    // Tri par urgence puis par nom
    patients.sort((a, b) {
      if (a['urgence'] && !b['urgence']) return -1;
      if (!a['urgence'] && b['urgence']) return 1;
      return a['nom'].compareTo(b['nom']);
    });

    return patients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dossiers Patients'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'export':
                  _exporterDonnees();
                  break;
                case 'import':
                  _importerDonnees();
                  break;
                case 'stats':
                  _afficherStatistiques();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download, size: 20),
                    SizedBox(width: 8),
                    Text('Exporter'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'import',
                child: Row(
                  children: [
                    Icon(Icons.upload, size: 20),
                    SizedBox(width: 8),
                    Text('Importer'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'stats',
                child: Row(
                  children: [
                    Icon(Icons.analytics, size: 20),
                    SizedBox(width: 8),
                    Text('Statistiques'),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'Liste'),
            Tab(icon: Icon(Icons.grid_view), text: 'Grille'),
            Tab(icon: Icon(Icons.analytics), text: 'Analyse'),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildListePatients(),
                _buildGrillePatients(),
                _buildAnalysePatients(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ajouterPatient,
        backgroundColor: Colors.green,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          // Barre de recherche
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher par nom ou ID patient...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 12),
          
          // Filtres
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filtres.map((filtre) {
                final isSelected = _selectedFilter == filtre;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filtre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filtre;
                      });
                    },
                    selectedColor: Colors.green.shade100,
                    checkmarkColor: Colors.green.shade700,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListePatients() {
    final patients = _patientsFiltres;
    
    if (patients.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return _buildPatientCard(patients[index]);
      },
    );
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    final Color statutColor = _getStatutColor(patient['statut']);
    final bool isUrgent = patient['urgence'] == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isUrgent ? 4 : 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isUrgent ? Border.all(color: Colors.red, width: 2) : null,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: statutColor.withOpacity(0.2),
                child: Text(
                  patient['nom'].toString().split(' ').map((n) => n[0]).join(''),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statutColor,
                  ),
                ),
              ),
              if (isUrgent)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  patient['nom'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statutColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  patient['statut'].toString().replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statutColor,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text('ID: ${patient['id']} • ${patient['age']} ans • ${patient['sexe']}'),
              Text('Médecin: ${patient['medecin_traitant']}'),
              Text('Dernière visite: ${patient['derniere_visite']}'),
              if (patient['allergies'].isNotEmpty)
                Text(
                  'Allergies: ${patient['allergies'].join(', ')}',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
            ],
          ),
          trailing: PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'voir',
                child: Row(
                  children: [
                    Icon(Icons.visibility, size: 20),
                    SizedBox(width: 8),
                    Text('Voir dossier'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'consultation',
                child: Row(
                  children: [
                    Icon(Icons.medical_services, size: 20),
                    SizedBox(width: 8),
                    Text('Nouvelle consultation'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'rdv',
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20),
                    SizedBox(width: 8),
                    Text('Programmer RDV'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'modifier',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 8),
                    Text('Modifier'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              _gererActionPatient(value, patient);
            },
          ),
          isThreeLine: true,
          onTap: () => _voirDossierPatient(patient),
        ),
      ),
    );
  }

  Widget _buildGrillePatients() {
    final patients = _patientsFiltres;
    
    if (patients.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return _buildPatientGridCard(patients[index]);
      },
    );
  }

  Widget _buildPatientGridCard(Map<String, dynamic> patient) {
    final Color statutColor = _getStatutColor(patient['statut']);
    final bool isUrgent = patient['urgence'] == true;

    return Card(
      elevation: isUrgent ? 4 : 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isUrgent ? Border.all(color: Colors.red, width: 2) : null,
        ),
        child: InkWell(
          onTap: () => _voirDossierPatient(patient),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: statutColor.withOpacity(0.2),
                      child: Text(
                        patient['nom'].toString().split(' ').map((n) => n[0]).join(''),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statutColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    if (isUrgent)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.priority_high,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  patient['nom'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${patient['age']} ans',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statutColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    patient['statut'].toString().replaceAll('_', ' ').toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statutColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${patient['nb_consultations']} consultations',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysePatients() {
    final patients = _patients;
    final totalPatients = patients.length;
    final patientsActifs = patients.where((p) => p['statut'] == 'actif').length;
    final patientsSuiviSpecial = patients.where((p) => p['statut'] == 'suivi_special').length;
    final patientsUrgents = patients.where((p) => p['urgence'] == true).length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Statistiques générales
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Statistiques Générales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('$totalPatients', 'Total Patients', Colors.blue),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('$patientsActifs', 'Actifs', Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('$patientsSuiviSpecial', 'Suivi Spécial', Colors.orange),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('$patientsUrgents', 'Urgents', Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Répartition par âge
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Répartition par Âge',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildAgeDistribution(patients),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Pathologies fréquentes
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pathologies Fréquentes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildPathologiesChart(patients),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
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
    );
  }

  Widget _buildAgeDistribution(List<Map<String, dynamic>> patients) {
    final ageRanges = {
      '0-18': 0,
      '19-30': 0,
      '31-50': 0,
      '51-70': 0,
      '70+': 0,
    };

    for (var patient in patients) {
      final age = patient['age'] as int;
      if (age <= 18) {
        ageRanges['0-18'] = ageRanges['0-18']! + 1;
      } else if (age <= 30) {
        ageRanges['19-30'] = ageRanges['19-30']! + 1;
      } else if (age <= 50) {
        ageRanges['31-50'] = ageRanges['31-50']! + 1;
      } else if (age <= 70) {
        ageRanges['51-70'] = ageRanges['51-70']! + 1;
      } else {
        ageRanges['70+'] = ageRanges['70+']! + 1;
      }
    }

    return Column(
      children: ageRanges.entries.map((entry) {
        final percentage = patients.isNotEmpty ? (entry.value / patients.length * 100) : 0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500)),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
                ),
              ),
              const SizedBox(width: 8),
              Text('${entry.value} (${percentage.toStringAsFixed(0)}%)'),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPathologiesChart(List<Map<String, dynamic>> patients) {
    final pathologies = <String, int>{};
    
    for (var patient in patients) {
      final patientPathologies = patient['pathologies'] as List<dynamic>;
      for (var pathologie in patientPathologies) {
        pathologies[pathologie] = (pathologies[pathologie] ?? 0) + 1;
      }
    }

    final sortedPathologies = pathologies.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: sortedPathologies.take(5).map((entry) {
        final percentage = patients.isNotEmpty ? (entry.value / patients.length * 100) : 0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 3,
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade300),
                ),
              ),
              const SizedBox(width: 8),
              Text('${entry.value}'),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun patient trouvé',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Essayez de modifier vos critères de recherche',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'actif':
        return Colors.green;
      case 'suivi_special':
        return Colors.orange;
      case 'inactif':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  void _toggleSearch() {
    // Logique pour afficher/masquer la recherche
    print('Toggle search');
  }

  void _exporterDonnees() {
    print('Exporter les données des patients');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export en cours...')),
    );
  }

  void _importerDonnees() {
    print('Importer des données de patients');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sélectionner le fichier à importer')),
    );
  }

  void _afficherStatistiques() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Statistiques Détaillées'),
        content: const Text('Fonctionnalité à implémenter'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _ajouterPatient() {
    print('Ajouter un nouveau patient');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formulaire d\'ajout de patient')),
    );
  }

  void _voirDossierPatient(Map<String, dynamic> patient) {
    print('Voir dossier de ${patient['nom']}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Ouverture du dossier de ${patient['nom']}')),
    );
  }

  void _gererActionPatient(String action, Map<String, dynamic> patient) {
    switch (action) {
      case 'voir':
        _voirDossierPatient(patient);
        break;
      case 'consultation':
        print('Nouvelle consultation pour ${patient['nom']}');
        break;
      case 'rdv':
        print('Programmer RDV pour ${patient['nom']}');
        break;
      case 'modifier':
        print('Modifier ${patient['nom']}');
        break;
    }
  }
}
