import 'package:flutter/material.dart';

class PlanningCentreScreen extends StatefulWidget {
  const PlanningCentreScreen({Key? key}) : super(key: key);

  @override
  State<PlanningCentreScreen> createState() => _PlanningCentreScreenState();
}

class _PlanningCentreScreenState extends State<PlanningCentreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  final Map<String, List<Map<String, dynamic>>> _rendezVous = {
    '2024-10-02': [
      {
        'heure': '08:00',
        'patient': 'Marie MARTIN',
        'medecin': 'Dr. Leroy',
        'type': 'Consultation générale',
        'statut': 'confirmé',
        'duree': 30,
      },
      {
        'heure': '08:30',
        'patient': 'Jean DUPONT',
        'medecin': 'Dr. Bernard',
        'type': 'Suivi cardiaque',
        'statut': 'confirmé',
        'duree': 45,
      },
      {
        'heure': '10:00',
        'patient': 'Sophie LEROY',
        'medecin': 'Dr. Leroy',
        'type': 'Première consultation',
        'statut': 'en_attente',
        'duree': 60,
      },
      {
        'heure': '14:00',
        'patient': 'Pierre MARTIN',
        'medecin': 'Dr. Bernard',
        'type': 'Consultation de routine',
        'statut': 'confirmé',
        'duree': 30,
      },
      {
        'heure': '15:30',
        'patient': 'Anne DUBOIS',
        'medecin': 'Dr. Leroy',
        'type': 'Consultation urgente',
        'statut': 'urgent',
        'duree': 30,
      },
    ],
    '2024-10-03': [
      {
        'heure': '09:00',
        'patient': 'Paul VINCENT',
        'medecin': 'Dr. Bernard',
        'type': 'Suivi diabète',
        'statut': 'confirmé',
        'duree': 30,
      },
      {
        'heure': '11:00',
        'patient': 'Claire MOREAU',
        'medecin': 'Dr. Leroy',
        'type': 'Consultation générale',
        'statut': 'confirmé',
        'duree': 30,
      },
    ],
  };

  final List<String> _medecins = ['Dr. Leroy', 'Dr. Bernard', 'Dr. Martin'];
  String? _medecinFiltre;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Planning du Centre'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAjouterCreneauDialog,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.calendar_today), text: 'Aujourd\'hui'),
            Tab(icon: Icon(Icons.view_week), text: 'Semaine'),
            Tab(icon: Icon(Icons.view_agenda), text: 'Agenda'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVueJournaliere(),
          _buildVueHebdomadaire(),
          _buildVueAgenda(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAjouterCreneauDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildVueJournaliere() {
    final dateKey = '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';
    final rdvDuJour = _rendezVous[dateKey] ?? [];
    final rdvFiltres = _medecinFiltre != null ? 
      rdvDuJour.where((rdv) => rdv['medecin'] == _medecinFiltre).toList() : rdvDuJour;

    return Column(
      children: [
        // Sélecteur de date
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                        });
                      },
                      icon: const Icon(Icons.chevron_left),
                    ),
                    ElevatedButton(
                      onPressed: _selectDate,
                      child: const Text('Changer'),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = _selectedDate.add(const Duration(days: 1));
                        });
                      },
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Statistiques du jour
        _buildStatistiquesJour(rdvFiltres),

        // Liste des rendez-vous
        Expanded(
          child: rdvFiltres.isEmpty ? 
            _buildEmptyState() : 
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: rdvFiltres.length,
              itemBuilder: (context, index) {
                return _buildRendezVousCard(rdvFiltres[index]);
              },
            ),
        ),
      ],
    );
  }

  Widget _buildVueHebdomadaire() {
    return Column(
      children: [
        // En-tête de la semaine
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Semaine du ${_selectedDate.day}/${_selectedDate.month}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.subtract(const Duration(days: 7));
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.add(const Duration(days: 7));
                      });
                    },
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Grille de la semaine
        Expanded(
          child: _buildGrilleSemaine(),
        ),
      ],
    );
  }

  Widget _buildVueAgenda() {
    final tousLesRdv = <Map<String, dynamic>>[];
    _rendezVous.forEach((date, rdvs) {
      for (var rdv in rdvs) {
        tousLesRdv.add({...rdv, 'date': date});
      }
    });

    tousLesRdv.sort((a, b) {
      final dateA = DateTime.parse('${a['date']} ${a['heure']}:00');
      final dateB = DateTime.parse('${b['date']} ${b['heure']}:00');
      return dateA.compareTo(dateB);
    });

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tousLesRdv.length,
      itemBuilder: (context, index) {
        final rdv = tousLesRdv[index];
        return _buildRendezVousCardAvecDate(rdv);
      },
    );
  }

  Widget _buildStatistiquesJour(List<Map<String, dynamic>> rdvs) {
    final confirmes = rdvs.where((rdv) => rdv['statut'] == 'confirmé').length;
    final enAttente = rdvs.where((rdv) => rdv['statut'] == 'en_attente').length;
    final urgents = rdvs.where((rdv) => rdv['statut'] == 'urgent').length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard('${rdvs.length}', 'Total RDV', Colors.blue),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatCard('$confirmes', 'Confirmés', Colors.green),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatCard('$enAttente', 'En attente', Colors.orange),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatCard('$urgents', 'Urgents', Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String nombre, String label, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              nombre,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRendezVousCard(Map<String, dynamic> rdv) {
    Color statutColor;
    IconData statutIcon;
    
    switch (rdv['statut']) {
      case 'confirmé':
        statutColor = Colors.green;
        statutIcon = Icons.check_circle;
        break;
      case 'en_attente':
        statutColor = Colors.orange;
        statutIcon = Icons.schedule;
        break;
      case 'urgent':
        statutColor = Colors.red;
        statutIcon = Icons.emergency;
        break;
      default:
        statutColor = Colors.grey;
        statutIcon = Icons.help;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: statutColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                rdv['heure'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: statutColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${rdv['duree']}min',
                style: TextStyle(
                  fontSize: 10,
                  color: statutColor,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          rdv['patient'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${rdv['medecin']} • ${rdv['type']}'),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(statutIcon, size: 16, color: statutColor),
                const SizedBox(width: 4),
                Text(
                  rdv['statut'].toString().toUpperCase(),
                  style: TextStyle(
                    color: statutColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
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
                  Text('Voir détails'),
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
            const PopupMenuItem<String>(
              value: 'annuler',
              child: Row(
                children: [
                  Icon(Icons.cancel, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Annuler', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            _gererActionRendezVous(value, rdv);
          },
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildRendezVousCardAvecDate(Map<String, dynamic> rdv) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Text(
            rdv['date'].split('-')[2],
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '${rdv['heure']} - ${rdv['patient']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${rdv['medecin']} • ${rdv['type']}'),
        trailing: Text(
          rdv['date'],
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildGrilleSemaine() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // En-têtes des jours
          Container(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: 60,
                  child: const Center(child: Text('Heure', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                ...List.generate(7, (index) {
                  final jour = _selectedDate.add(Duration(days: index - _selectedDate.weekday + 1));
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _getJourSemaine(jour.weekday),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              '${jour.day}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          // Grille des créneaux
          ...List.generate(20, (hourIndex) {
            final heure = 8 + hourIndex;
            if (heure > 18) return Container();
            
            return Container(
              height: 60,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        '${heure.toString().padLeft(2, '0')}:00',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  ...List.generate(7, (dayIndex) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: _buildCreneauSemaine(heure, dayIndex),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCreneauSemaine(int heure, int dayIndex) {
    // Ici vous pourriez ajouter la logique pour afficher les RDV dans chaque créneau
    return InkWell(
      onTap: () {
        print('Créneau cliqué: ${heure}h, jour $dayIndex');
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: Text('', style: TextStyle(fontSize: 10)),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun rendez-vous aujourd\'hui',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Profitez de cette journée plus calme !',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  String _getJourSemaine(int weekday) {
    switch (weekday) {
      case 1: return 'Lun';
      case 2: return 'Mar';
      case 3: return 'Mer';
      case 4: return 'Jeu';
      case 5: return 'Ven';
      case 6: return 'Sam';
      case 7: return 'Dim';
      default: return '';
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filtrer par médecin'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Tous les médecins'),
                leading: Radio<String?>(
                  value: null,
                  groupValue: _medecinFiltre,
                  onChanged: (value) {
                    setState(() {
                      _medecinFiltre = value;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ..._medecins.map((medecin) => ListTile(
                title: Text(medecin),
                leading: Radio<String?>(
                  value: medecin,
                  groupValue: _medecinFiltre,
                  onChanged: (value) {
                    setState(() {
                      _medecinFiltre = value;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  void _showAjouterCreneauDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un créneau'),
          content: const Text('Fonctionnalité à implémenter : formulaire d\'ajout de créneau'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _gererActionRendezVous(String action, Map<String, dynamic> rdv) {
    switch (action) {
      case 'voir':
        print('Voir détails de ${rdv['patient']}');
        break;
      case 'modifier':
        print('Modifier RDV de ${rdv['patient']}');
        break;
      case 'annuler':
        _confirmerAnnulation(rdv);
        break;
    }
  }

  void _confirmerAnnulation(Map<String, dynamic> rdv) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer l\'annulation'),
          content: Text('Êtes-vous sûr de vouloir annuler le rendez-vous de ${rdv['patient']} ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Non'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('RDV annulé pour ${rdv['patient']}');
                // Ici vous ajouteriez la logique d'annulation
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Oui, annuler', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
