import 'package:flutter/material.dart';

class ParametresPatientScreen extends StatefulWidget {
  const ParametresPatientScreen({Key? key}) : super(key: key);

  @override
  State<ParametresPatientScreen> createState() => _ParametresPatientScreenState();
}

class _ParametresPatientScreenState extends State<ParametresPatientScreen> {
  bool _notificationsRdv = true;
  bool _notificationsRappels = true;
  bool _notificationsResultats = true;
  bool _notificationsSms = true;
  bool _notificationsEmail = false;
  bool _partageAnonymise = false;
  bool _biometrieActive = false;
  String _langue = 'Français';
  String _theme = 'Système';

  final List<String> _languesDisponibles = ['Français', 'English', 'Español'];
  final List<String> _themesDisponibles = ['Système', 'Clair', 'Sombre'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildSectionProfil(),
          _buildSectionNotifications(),
          _buildSectionSecurite(),
          _buildSectionDonnees(),
          _buildSectionApplication(),
          _buildSectionSupport(),
        ],
      ),
    );
  }

  Widget _buildSectionProfil() {
    return _buildSection(
      title: 'Profil',
      icon: Icons.person,
      children: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Modifier mes informations'),
          subtitle: const Text('Nom, téléphone, adresse...'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Modifier profil'),
        ),
        ListTile(
          leading: const Icon(Icons.medical_information),
          title: const Text('Informations médicales'),
          subtitle: const Text('Allergies, groupe sanguin, contact d\'urgence'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Informations médicales'),
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Photo de profil'),
          subtitle: const Text('Modifier votre photo'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Changer photo'),
        ),
      ],
    );
  }

  Widget _buildSectionNotifications() {
    return _buildSection(
      title: 'Notifications',
      icon: Icons.notifications,
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.calendar_today),
          title: const Text('Rappels de rendez-vous'),
          subtitle: const Text('24h avant votre RDV'),
          value: _notificationsRdv,
          onChanged: (value) {
            setState(() {
              _notificationsRdv = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.medication),
          title: const Text('Rappels de traitement'),
          subtitle: const Text('Prendre vos médicaments'),
          value: _notificationsRappels,
          onChanged: (value) {
            setState(() {
              _notificationsRappels = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.science),
          title: const Text('Résultats d\'analyses'),
          subtitle: const Text('Quand vos résultats sont disponibles'),
          value: _notificationsResultats,
          onChanged: (value) {
            setState(() {
              _notificationsResultats = value;
            });
          },
        ),
        const Divider(),
        SwitchListTile(
          secondary: const Icon(Icons.sms),
          title: const Text('Notifications SMS'),
          value: _notificationsSms,
          onChanged: (value) {
            setState(() {
              _notificationsSms = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.email),
          title: const Text('Notifications Email'),
          value: _notificationsEmail,
          onChanged: (value) {
            setState(() {
              _notificationsEmail = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSectionSecurite() {
    return _buildSection(
      title: 'Sécurité',
      icon: Icons.security,
      children: [
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Changer le mot de passe'),
          subtitle: const Text('Modifier votre mot de passe'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showChangePasswordDialog(),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.fingerprint),
          title: const Text('Authentification biométrique'),
          subtitle: const Text('Déverrouiller avec empreinte/Face ID'),
          value: _biometrieActive,
          onChanged: (value) {
            setState(() {
              _biometrieActive = value;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.devices),
          title: const Text('Appareils connectés'),
          subtitle: const Text('Gérer vos sessions actives'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Appareils connectés'),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Historique de connexion'),
          subtitle: const Text('Voir vos dernières connexions'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Historique connexion'),
        ),
      ],
    );
  }

  Widget _buildSectionDonnees() {
    return _buildSection(
      title: 'Données & Confidentialité',
      icon: Icons.privacy_tip,
      children: [
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Télécharger mes données'),
          subtitle: const Text('Exporter toutes vos données médicales'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showExportDialog(),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.analytics),
          title: const Text('Partage anonymisé'),
          subtitle: const Text('Contribuer à la recherche médicale'),
          value: _partageAnonymise,
          onChanged: (value) {
            setState(() {
              _partageAnonymise = value;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.policy),
          title: const Text('Politique de confidentialité'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Politique confidentialité'),
        ),
        ListTile(
          leading: const Icon(Icons.article),
          title: const Text('Conditions d\'utilisation'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('CGU'),
        ),
      ],
    );
  }

  Widget _buildSectionApplication() {
    return _buildSection(
      title: 'Application',
      icon: Icons.settings,
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Langue'),
          subtitle: Text(_langue),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showLanguageDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.palette),
          title: const Text('Thème'),
          subtitle: Text(_theme),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showThemeDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.storage),
          title: const Text('Stockage'),
          subtitle: const Text('Gérer le cache et les données locales'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showStorageDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('À propos'),
          subtitle: const Text('Version 1.0.0 - VITALIA'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showAboutDialog(),
        ),
      ],
    );
  }

  Widget _buildSectionSupport() {
    return _buildSection(
      title: 'Support',
      icon: Icons.help,
      children: [
        ListTile(
          leading: const Icon(Icons.help_center),
          title: const Text('Centre d\'aide'),
          subtitle: const Text('FAQ et guides d\'utilisation'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Centre d\'aide'),
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          title: const Text('Contacter le support'),
          subtitle: const Text('Nous sommes là pour vous aider'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Contacter support'),
        ),
        ListTile(
          leading: const Icon(Icons.bug_report),
          title: const Text('Signaler un problème'),
          subtitle: const Text('Rapporter un bug ou dysfonctionnement'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Signaler problème'),
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Noter l\'application'),
          subtitle: const Text('Donnez-nous votre avis'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Noter app'),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: children),
        ),
      ],
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer le mot de passe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe actuel',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmer le nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mot de passe modifié avec succès')),
              );
            },
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir la langue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languesDisponibles.map((langue) {
            return RadioListTile<String>(
              title: Text(langue),
              value: langue,
              groupValue: _langue,
              onChanged: (value) {
                setState(() {
                  _langue = value!;
                });
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choisir le thème'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _themesDisponibles.map((theme) {
            return RadioListTile<String>(
              title: Text(theme),
              value: theme,
              groupValue: _theme,
              onChanged: (value) {
                setState(() {
                  _theme = value!;
                });
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exporter vos données'),
        content: const Text(
          'Vous recevrez un email avec toutes vos données médicales dans un délai de 24-48h.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export demandé, vous recevrez un email')),
              );
            },
            child: const Text('Exporter'),
          ),
        ],
      ),
    );
  }

  void _showStorageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gestion du stockage'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cache: 45 MB'),
            const Text('Documents: 12 MB'),
            const Text('Images: 8 MB'),
            const SizedBox(height: 16),
            const Text('Total utilisé: 65 MB'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache vidé')),
              );
            },
            child: const Text('Vider le cache'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'VITALIA',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.local_hospital, size: 48, color: Colors.blue),
      children: [
        const Text('Application de gestion médicale digitale.'),
        const SizedBox(height: 16),
        const Text('© 2024 VITALIA. Tous droits réservés.'),
      ],
    );
  }
}
