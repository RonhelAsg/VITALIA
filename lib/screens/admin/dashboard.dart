import 'package:flutter/material.dart';
import 'parametres.dart';
import 'gestion_utilisateurs.dart';
import 'gestion_centres.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration VITALIA'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings, size: 20),
                    SizedBox(width: 8),
                    Text('Profil Admin'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 20),
                    SizedBox(width: 8),
                    Text('Paramètres Système'),
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
                  print('Navigation vers profil admin');
                  break;
                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ParametresAdminScreen()),
                  );
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
          // CARTE ADMIN INFO
          _buildAdminInfoCard(),
          const SizedBox(height: 20),

          // STATISTIQUES GLOBALES
          _buildGlobalStats(),
          const SizedBox(height: 20),

          // ACTIONS D'ADMINISTRATION
          _buildAdminActions(),
          const SizedBox(height: 20),

          // ACTIVITÉS RÉCENTES
          _buildRecentActivities(),
          const SizedBox(height: 20),

          // ALERTES SYSTÈME
          _buildSystemAlerts(),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Déconnexion Admin'),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('Déconnexion admin');
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

  Widget _buildAdminInfoCard() {
    return Card(
      elevation: 4,
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red.shade100,
              child: Icon(Icons.admin_panel_settings, size: 30, color: Colors.red.shade700),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Administrateur Principal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID ADMIN: ADM-0001',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dernière connexion: Aujourd\'hui 08:30',
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

  Widget _buildGlobalStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statistiques Globales',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                '1,247',
                'Patients',
                Icons.people,
                Colors.blue,
                '+25 cette semaine',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                '45',
                'Centres de Santé',
                Icons.local_hospital,
                Colors.green,
                '+3 ce mois',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                '8,956',
                'Consultations',
                Icons.medical_services,
                Colors.orange,
                '+156 aujourd\'hui',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                '99.2%',
                'Disponibilité',
                Icons.analytics,
                Colors.purple,
                'Excellent',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color, String subtitle) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actions d\'Administration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Gérer Utilisateurs',
                Icons.group,
                Colors.blue,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GestionUtilisateursScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Centres de Santé',
                Icons.local_hospital,
                Colors.green,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => GestionCentresScreen()),
                  );
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
                'Rapports',
                Icons.assessment,
                Colors.orange,
                    () => print('Voir rapports'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Sécurité',
                Icons.security,
                Colors.red,
                    () => print('Paramètres sécurité'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
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

  Widget _buildRecentActivities() {
    final activities = [
      {
        'action': 'Nouveau centre ajouté',
        'details': 'Clinique Sainte-Marie - Paris 15ème',
        'time': 'Il y a 2h',
        'icon': Icons.add_business,
        'color': Colors.green,
      },
      {
        'action': 'Utilisateur suspendu',
        'details': 'Centre ID: CENT-0023 - Violation conditions',
        'time': 'Il y a 5h',
        'icon': Icons.block,
        'color': Colors.red,
      },
      {
        'action': 'Mise à jour système',
        'details': 'Version 2.1.4 déployée avec succès',
        'time': 'Hier 14:30',
        'icon': Icons.system_update,
        'color': Colors.blue,
      },
      {
        'action': 'Rapport généré',
        'details': 'Statistiques mensuelles - Septembre 2024',
        'time': 'Hier 09:15',
        'icon': Icons.description,
        'color': Colors.orange,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activités Récentes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...activities.map((activity) => _buildActivityCard(activity)),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (activity['color'] as Color).withOpacity(0.1),
          child: Icon(
            activity['icon'] as IconData,
            color: activity['color'] as Color,
            size: 20,
          ),
        ),
        title: Text(
          activity['action'] as String,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(activity['details'] as String),
        trailing: Text(
          activity['time'] as String,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildSystemAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Alertes Système',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.orange.shade50,
          child: ListTile(
            leading: Icon(Icons.warning, color: Colors.orange.shade700),
            title: const Text('Maintenance Programmée'),
            subtitle: const Text('Mise à jour de sécurité prévue le 15 Oct à 02:00'),
            trailing: TextButton(
              onPressed: () => print('Voir détails maintenance'),
              child: const Text('Détails'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          color: Colors.blue.shade50,
          child: ListTile(
            leading: Icon(Icons.info, color: Colors.blue.shade700),
            title: const Text('Nouveaux Centres en Attente'),
            subtitle: const Text('3 demandes d\'inscription à valider'),
            trailing: TextButton(
              onPressed: () => print('Voir demandes'),
              child: const Text('Examiner'),
            ),
          ),
        ),
      ],
    );
  }
}