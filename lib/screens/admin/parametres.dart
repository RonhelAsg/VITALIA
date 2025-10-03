import 'package:flutter/material.dart';

class ParametresAdminScreen extends StatefulWidget {
  const ParametresAdminScreen({Key? key}) : super(key: key);

  @override
  State<ParametresAdminScreen> createState() => _ParametresAdminScreenState();
}

class _ParametresAdminScreenState extends State<ParametresAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres Système'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // SECTION GÉNÉRAL
          _buildSectionHeader('Général'),
          _buildSettingCard(
            'Configuration Système',
            'Paramètres généraux de l\'application',
            Icons.settings,
                () => print('Config système'),
          ),
          _buildSettingCard(
            'Base de Données',
            'Gestion et maintenance de la base de données',
            Icons.storage,
                () => print('Config BDD'),
          ),

          const SizedBox(height: 20),

          // SECTION SÉCURITÉ
          _buildSectionHeader('Sécurité'),
          _buildSettingCard(
            'Authentification',
            'Paramètres de sécurité et d\'authentification',
            Icons.security,
                () => print('Config auth'),
          ),
          _buildSettingCard(
            'Logs d\'Audit',
            'Consultation des logs de sécurité',
            Icons.history,
                () => print('Voir logs'),
          ),

          const SizedBox(height: 20),

          // SECTION UTILISATEURS
          _buildSectionHeader('Gestion des Utilisateurs'),
          _buildSettingCard(
            'Rôles et Permissions',
            'Configuration des droits d\'accès',
            Icons.admin_panel_settings,
                () => print('Config rôles'),
          ),
          _buildSettingCard(
            'Comptes Administrateurs',
            'Gestion des comptes administrateurs',
            Icons.supervisor_account,
                () => print('Config admins'),
          ),

          const SizedBox(height: 20),

          // SECTION SYSTÈME
          _buildSectionHeader('Système'),
          _buildSettingCard(
            'Maintenance',
            'Programmation et gestion des maintenances',
            Icons.build,
                () => print('Maintenance'),
          ),
          _buildSettingCard(
            'Sauvegardes',
            'Configuration des sauvegardes automatiques',
            Icons.backup,
                () => print('Config backup'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade700,
        ),
      ),
    );
  }

  Widget _buildSettingCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red.shade50,
          child: Icon(icon, color: Colors.red.shade700),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
