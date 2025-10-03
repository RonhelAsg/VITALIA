import 'package:flutter/material.dart';

class GestionUtilisateursScreen extends StatefulWidget {
  const GestionUtilisateursScreen({Key? key}) : super(key: key);

  @override
  State<GestionUtilisateursScreen> createState() => _GestionUtilisateursScreenState();
}

class _GestionUtilisateursScreenState extends State<GestionUtilisateursScreen> {
  String _filtreType = 'tous';
  String _filtreStatut = 'tous';
  final _rechercheController = TextEditingController();

  final List<Map<String, dynamic>> _utilisateurs = [
    {
      'id': 'PAT-001',
      'nom': 'Dupont',
      'prenom': 'Marie',
      'email': 'marie.dupont@email.com',
      'type': 'patient',
      'statut': 'actif',
      'dateInscription': '2024-09-15',
      'telephone': '+33 6 12 34 56 78',
    },
    {
      'id': 'CENT-023',
      'nom': 'Clinique Paris Centre',
      'prenom': '',
      'email': 'contact@clinique-paris.fr',
      'type': 'centre',
      'statut': 'actif',
      'dateInscription': '2024-08-20',
      'telephone': '+33 1 45 67 89 10',
    },
    {
      'id': 'PAT-156',
      'nom': 'Martin',
      'prenom': 'Pierre',
      'email': 'pierre.martin@email.com',
      'type': 'patient',
      'statut': 'inactif',
      'dateInscription': '2024-10-01',
      'telephone': '+33 6 98 76 54 32',
    },
    {
      'id': 'ADM-002',
      'nom': 'Admin',
      'prenom': 'Technical',
      'email': 'tech@vitalia.com',
      'type': 'admin',
      'statut': 'actif',
      'dateInscription': '2024-07-10',
      'telephone': '+33 1 23 45 67 89',
    },
    {
      'id': 'CENT-045',
      'nom': 'Hôpital Saint-Louis',
      'prenom': '',
      'email': 'admin@hopital-saintlouis.fr',
      'type': 'centre',
      'statut': 'en_attente',
      'dateInscription': '2024-10-03',
      'telephone': '+33 1 34 56 78 90',
    },
  ];

  List<Map<String, dynamic>> get _utilisateursFiltres {
    return _utilisateurs.where((user) {
      final matchType = _filtreType == 'tous' || user['type'] == _filtreType;
      final matchStatut = _filtreStatut == 'tous' || user['statut'] == _filtreStatut;
      final matchRecherche = _rechercheController.text.isEmpty ||
          user['nom'].toString().toLowerCase().contains(_rechercheController.text.toLowerCase()) ||
          user['email'].toString().toLowerCase().contains(_rechercheController.text.toLowerCase()) ||
          user['id'].toString().toLowerCase().contains(_rechercheController.text.toLowerCase());

      return matchType && matchStatut && matchRecherche;
    }).toList();
  }

  void _modifierUtilisateur(Map<String, dynamic> user) {
    print('Modifier utilisateur: ${user['id']}');
    // Navigation vers page modification
  }

  void _changerStatut(String userId, String nouveauStatut) {
    setState(() {
      final user = _utilisateurs.firstWhere((u) => u['id'] == userId);
      user['statut'] = nouveauStatut;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Statut de $userId mis à jour: $nouveauStatut')),
    );
  }

  void _showActions(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.edit, color: Colors.blue),
            title: Text('Modifier'),
            onTap: () {
              Navigator.pop(context);
              _modifierUtilisateur(user);
            },
          ),
          if (user['statut'] == 'actif')
            ListTile(
              leading: Icon(Icons.pause, color: Colors.orange),
              title: Text('Suspendre'),
              onTap: () {
                Navigator.pop(context);
                _changerStatut(user['id'], 'inactif');
              },
            ),
          if (user['statut'] == 'inactif')
            ListTile(
              leading: Icon(Icons.play_arrow, color: Colors.green),
              title: Text('Activer'),
              onTap: () {
                Navigator.pop(context);
                _changerStatut(user['id'], 'actif');
              },
            ),
          if (user['statut'] == 'en_attente')
            ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text('Approuver'),
              onTap: () {
                Navigator.pop(context);
                _changerStatut(user['id'], 'actif');
              },
            ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Supprimer', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(user);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer l\'utilisateur ?'),
        content: Text('Êtes-vous sûr de vouloir supprimer ${user['nom']} ${user['prenom']} (${user['id']}) ? Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _utilisateurs.removeWhere((u) => u['id'] == user['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Utilisateur ${user['id']} supprimé')),
              );
            },
            child: Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Color _getStatutColor(String statut) {
    switch (statut) {
      case 'actif': return Colors.green;
      case 'inactif': return Colors.orange;
      case 'en_attente': return Colors.blue;
      default: return Colors.grey;
    }
  }

  String _getStatutText(String statut) {
    switch (statut) {
      case 'actif': return 'Actif';
      case 'inactif': return 'Inactif';
      case 'en_attente': return 'En attente';
      default: return statut;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'patient': return Icons.person;
      case 'centre': return Icons.local_hospital;
      case 'admin': return Icons.admin_panel_settings;
      default: return Icons.person;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'patient': return Colors.blue;
      case 'centre': return Colors.green;
      case 'admin': return Colors.purple;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Utilisateurs'),
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
                    labelText: 'Rechercher...',
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
                // Filtres
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _filtreType,
                        items: const [
                          DropdownMenuItem(value: 'tous', child: Text('Tous les types')),
                          DropdownMenuItem(value: 'patient', child: Text('Patients')),
                          DropdownMenuItem(value: 'centre', child: Text('Centres')),
                          DropdownMenuItem(value: 'admin', child: Text('Admins')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _filtreType = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
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
                          labelText: 'Statut',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // STATISTIQUES RAPIDES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatChip('Total: ${_utilisateursFiltres.length}', Colors.grey),
                const SizedBox(width: 8),
                _buildStatChip('Patients: ${_utilisateursFiltres.where((u) => u['type'] == 'patient').length}', Colors.blue),
                const SizedBox(width: 8),
                _buildStatChip('Centres: ${_utilisateursFiltres.where((u) => u['type'] == 'centre').length}', Colors.green),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // LISTE DES UTILISATEURS
          Expanded(
            child: ListView.builder(
              itemCount: _utilisateursFiltres.length,
              itemBuilder: (context, index) {
                final user = _utilisateursFiltres[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getTypeColor(user['type']).withOpacity(0.1),
                      child: Icon(
                        _getTypeIcon(user['type']),
                        color: _getTypeColor(user['type']),
                        size: 20,
                      ),
                    ),
                    title: Text(
                      user['type'] == 'centre'
                          ? user['nom']
                          : '${user['prenom']} ${user['nom']}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user['email']),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatutColor(user['statut']).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _getStatutColor(user['statut'])),
                              ),
                              child: Text(
                                _getStatutText(user['statut']),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getStatutColor(user['statut']),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              user['id'],
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () => _showActions(context, user),
                    ),
                    onTap: () => _showActions(context, user),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
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
}