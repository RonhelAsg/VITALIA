import 'package:flutter/material.dart';

class ParametresAdminScreen extends StatefulWidget {
  const ParametresAdminScreen({Key? key}) : super(key: key);

  @override
  State<ParametresAdminScreen> createState() => _ParametresAdminScreenState();
}

class _ParametresAdminScreenState extends State<ParametresAdminScreen> {
  bool _maintenanceMode = false;
  bool _debugMode = false;
  bool _analyticsActive = true;
  bool _emailAlerts = true;
  bool _smsAlerts = false;
  bool _autoBackup = true;
  bool _auditLogging = true;
  String _niveauSecurite = 'Élevé';
  String _frequenceBackup = 'Quotidienne';

  final List<String> _niveauxSecurite = ['Standard', 'Élevé', 'Maximum'];
  final List<String> _frequencesBackup = ['Temps réel', 'Quotidienne', 'Hebdomadaire'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration Système'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildSectionSysteme(),
          _buildSectionUtilisateurs(),
          _buildSectionSauvegarde(),
          _buildSectionSecurite(),
          _buildSectionNotifications(),
          _buildSectionAnalytics(),
          _buildSectionMaintenance(),
          _buildSectionSupport(),
        ],
      ),
    );
  }

  Widget _buildSectionSysteme() {
    return _buildSection(
      title: 'Système',
      icon: Icons.settings_system_daydream,
      children: [
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Informations système'),
          subtitle: const Text('Version 1.0.0 - Serveur: EU-West-1'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showSystemInfoDialog(),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.construction),
          title: const Text('Mode maintenance'),
          subtitle: const Text('Bloquer l\'accès aux utilisateurs'),
          value: _maintenanceMode,
          onChanged: (value) {
            _showMaintenanceConfirmation(value);
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.bug_report),
          title: const Text('Mode debug'),
          subtitle: const Text('Logs détaillés et diagnostics'),
          value: _debugMode,
          onChanged: (value) {
            setState(() {
              _debugMode = value;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.update),
          title: const Text('Mises à jour système'),
          subtitle: const Text('Dernière vérification: Il y a 2h'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _checkUpdates(),
        ),
        ListTile(
          leading: const Icon(Icons.storage),
          title: const Text('Gestion base de données'),
          subtitle: const Text('Optimisation et maintenance'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showDatabaseDialog(),
        ),
      ],
    );
  }

  Widget _buildSectionUtilisateurs() {
    return _buildSection(
      title: 'Gestion des Utilisateurs',
      icon: Icons.admin_panel_settings,
      children: [
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Utilisateurs actifs'),
          subtitle: const Text('1,247 patients • 45 centres • 3 admins'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Gestion utilisateurs'),
        ),
        ListTile(
          leading: const Icon(Icons.pending_actions),
          title: const Text('Demandes en attente'),
          subtitle: const Text('12 centres à valider'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Demandes en attente'),
        ),
        ListTile(
          leading: const Icon(Icons.block),
          title: const Text('Utilisateurs suspendus'),
          subtitle: const Text('Gérer les comptes bloqués'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Utilisateurs suspendus'),
        ),
        ListTile(
          leading: const Icon(Icons.security),
          title: const Text('Permissions & Rôles'),
          subtitle: const Text('Configurer les accès'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showPermissionsDialog(),
        ),
      ],
    );
  }

  Widget _buildSectionSauvegarde() {
    return _buildSection(
      title: 'Sauvegarde & Données',
      icon: Icons.backup,
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.schedule),
          title: const Text('Sauvegarde automatique'),
          subtitle: Text('$_frequenceBackup à 02:00'),
          value: _autoBackup,
          onChanged: (value) {
            setState(() {
              _autoBackup = value;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.tune),
          title: const Text('Configuration sauvegarde'),
          subtitle: Text('Fréquence: $_frequenceBackup'),
          trailing: const Icon(Icons.edit),
          onTap: () => _showBackupConfigDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Historique des sauvegardes'),
          subtitle: const Text('Dernière: Aujourd\'hui 02:00 (Succès)'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showBackupHistoryDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.cloud_upload),
          title: const Text('Sauvegarde manuelle'),
          subtitle: const Text('Lancer une sauvegarde immédiate'),
          trailing: const Icon(Icons.play_arrow),
          onTap: () => _startManualBackup(),
        ),
        ListTile(
          leading: const Icon(Icons.restore),
          title: const Text('Restaurer données'),
          subtitle: const Text('Restaurer depuis une sauvegarde'),
          trailing: const Icon(Icons.warning, color: Colors.red),
          onTap: () => _showRestoreDialog(),
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
          leading: const Icon(Icons.shield),
          title: const Text('Niveau de sécurité'),
          subtitle: Text(_niveauSecurite),
          trailing: const Icon(Icons.edit),
          onTap: () => _showSecurityLevelDialog(),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.article),
          title: const Text('Journal d\'audit'),
          subtitle: const Text('Enregistrer toutes les actions'),
          value: _auditLogging,
          onChanged: (value) {
            setState(() {
              _auditLogging = value;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Politiques de mots de passe'),
          subtitle: const Text('Complexité et expiration'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showPasswordPolicyDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.vpn_key),
          title: const Text('Authentification 2FA'),
          subtitle: const Text('Obligatoire pour les admins'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Configuration 2FA'),
        ),
        ListTile(
          leading: const Icon(Icons.verified_user),
          title: const Text('Certificats SSL'),
          subtitle: const Text('Expire le 15/12/2024'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Gestion SSL'),
        ),
        ListTile(
          leading: const Icon(Icons.warning),
          title: const Text('Tentatives de connexion'),
          subtitle: const Text('Surveiller les accès suspects'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showSecurityAlertsDialog(),
        ),
      ],
    );
  }

  Widget _buildSectionNotifications() {
    return _buildSection(
      title: 'Notifications Admin',
      icon: Icons.notifications,
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.email),
          title: const Text('Alertes par email'),
          subtitle: const Text('admin@vitalia.com'),
          value: _emailAlerts,
          onChanged: (value) {
            setState(() {
              _emailAlerts = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.sms),
          title: const Text('Alertes par SMS'),
          subtitle: const Text('Pour les urgences critiques'),
          value: _smsAlerts,
          onChanged: (value) {
            setState(() {
              _smsAlerts = value;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.tune),
          title: const Text('Configurer les alertes'),
          subtitle: const Text('Types et seuils d\'alerte'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showAlertsConfigDialog(),
        ),
      ],
    );
  }

  Widget _buildSectionAnalytics() {
    return _buildSection(
      title: 'Analytics & Monitoring',
      icon: Icons.analytics,
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.insights),
          title: const Text('Analytics activées'),
          subtitle: const Text('Collecte des données d\'usage'),
          value: _analyticsActive,
          onChanged: (value) {
            setState(() {
              _analyticsActive = value;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text('Tableau de bord métrique'),
          subtitle: const Text('Performance et utilisation'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Métriques système'),
        ),
        ListTile(
          leading: const Icon(Icons.speed),
          title: const Text('Performance système'),
          subtitle: const Text('CPU: 45% • RAM: 62% • Stockage: 78%'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showPerformanceDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.timeline),
          title: const Text('Logs système'),
          subtitle: const Text('Journaux et erreurs'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Logs système'),
        ),
      ],
    );
  }

  Widget _buildSectionMaintenance() {
    return _buildSection(
      title: 'Maintenance',
      icon: Icons.build,
      children: [
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text('Maintenance programmée'),
          subtitle: const Text('Prochaine: 15 Oct 2024 à 02:00'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showMaintenanceScheduleDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.cleaning_services),
          title: const Text('Nettoyage base de données'),
          subtitle: const Text('Optimiser les performances'),
          trailing: const Icon(Icons.play_arrow),
          onTap: () => _startDatabaseCleanup(),
        ),
        ListTile(
          leading: const Icon(Icons.delete_sweep),
          title: const Text('Purger les logs'),
          subtitle: const Text('Supprimer les anciens journaux'),
          trailing: const Icon(Icons.play_arrow),
          onTap: () => _purgeLogs(),
        ),
        ListTile(
          leading: const Icon(Icons.restart_alt),
          title: const Text('Redémarrer les services'),
          subtitle: const Text('Redémarrage des composants système'),
          trailing: const Icon(Icons.warning, color: Colors.orange),
          onTap: () => _showRestartDialog(),
        ),
      ],
    );
  }

  Widget _buildSectionSupport() {
    return _buildSection(
      title: 'Support & Documentation',
      icon: Icons.support,
      children: [
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Documentation admin'),
          subtitle: const Text('Guides et procédures'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Documentation'),
        ),
        ListTile(
          leading: const Icon(Icons.contact_support),
          title: const Text('Support technique'),
          subtitle: const Text('Assistance prioritaire 24h/24'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Contact support'),
        ),
        ListTile(
          leading: const Icon(Icons.bug_report),
          title: const Text('Signaler un incident'),
          subtitle: const Text('Rapporter un problème critique'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Signaler incident'),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('À propos du système'),
          subtitle: const Text('VITALIA Admin Panel v1.0.0'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showAboutDialog(),
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
              Icon(icon, color: Colors.red.shade700),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
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

  void _showMaintenanceConfirmation(bool value) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(value ? 'Activer le mode maintenance' : 'Désactiver le mode maintenance'),
        content: Text(
          value 
            ? 'Cela va bloquer l\'accès à tous les utilisateurs. Continuer ?'
            : 'Les utilisateurs pourront à nouveau accéder au système.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _maintenanceMode = value;
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value ? 'Mode maintenance activé' : 'Mode maintenance désactivé'),
                  backgroundColor: value ? Colors.orange : Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: value ? Colors.orange : Colors.green,
            ),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _showSystemInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informations Système'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: VITALIA 1.0.0'),
            Text('Serveur: EU-West-1'),
            Text('Base de données: PostgreSQL 14.2'),
            Text('Temps de fonctionnement: 15 jours 4h 23min'),
            Text('Dernière mise à jour: 01/10/2024'),
            SizedBox(height: 16),
            Text('Ressources:'),
            Text('• CPU: 45% (4 cœurs)'),
            Text('• RAM: 62% (8 GB)'),
            Text('• Stockage: 78% (500 GB)'),
            Text('• Réseau: 12 Mbps'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _checkUpdates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Vérification des mises à jour en cours...'),
        duration: Duration(seconds: 2),
      ),
    );
    
    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Système à jour - Aucune mise à jour disponible'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void _showDatabaseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gestion Base de Données'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Analyser les performances'),
              subtitle: Text('Identifier les requêtes lentes'),
            ),
            ListTile(
              leading: Icon(Icons.compress),
              title: Text('Optimiser les index'),
              subtitle: Text('Améliorer les performances'),
            ),
            ListTile(
              leading: Icon(Icons.cleaning_services),
              title: Text('Nettoyer les données'),
              subtitle: Text('Supprimer les données obsolètes'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showPermissionsDialog() {
    final roles = ['Admin', 'Centre de Santé', 'Patient', 'Support'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permissions & Rôles'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: roles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(roles[index]),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  print('Éditer permissions ${roles[index]}');
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showBackupConfigDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configuration Sauvegarde'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Fréquence de sauvegarde:'),
            ..._frequencesBackup.map((freq) {
              return RadioListTile<String>(
                title: Text(freq),
                value: freq,
                groupValue: _frequenceBackup,
                onChanged: (value) {
                  setState(() {
                    _frequenceBackup = value!;
                  });
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showBackupHistoryDialog() {
    final backups = [
      {'date': '02/10/2024 02:00', 'statut': 'Succès', 'taille': '2.3 GB'},
      {'date': '01/10/2024 02:00', 'statut': 'Succès', 'taille': '2.2 GB'},
      {'date': '30/09/2024 02:00', 'statut': 'Échec', 'taille': '-'},
      {'date': '29/09/2024 02:00', 'statut': 'Succès', 'taille': '2.1 GB'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historique des Sauvegardes'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: backups.length,
            itemBuilder: (context, index) {
              final backup = backups[index];
              final isSuccess = backup['statut'] == 'Succès';
              return ListTile(
                leading: Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
                title: Text(backup['date']!),
                subtitle: Text('${backup['statut']} - ${backup['taille']}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _startManualBackup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sauvegarde Manuelle'),
        content: const Text('Démarrer une sauvegarde complète maintenant ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sauvegarde manuelle démarrée...'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Démarrer'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Restaurer les Données'),
        content: const Text(
          'ATTENTION: Cette opération va remplacer toutes les données actuelles. '
          'Assurez-vous d\'avoir une sauvegarde récente avant de continuer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              print('Processus de restauration');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Restaurer', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSecurityLevelDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Niveau de Sécurité'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _niveauxSecurite.map((niveau) {
            return RadioListTile<String>(
              title: Text(niveau),
              value: niveau,
              groupValue: _niveauSecurite,
              onChanged: (value) {
                setState(() {
                  _niveauSecurite = value!;
                });
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showPasswordPolicyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Politique des Mots de Passe'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Règles actuelles:'),
            SizedBox(height: 8),
            Text('• Minimum 8 caractères'),
            Text('• Au moins 1 majuscule'),
            Text('• Au moins 1 chiffre'),
            Text('• Au moins 1 caractère spécial'),
            Text('• Expiration: 90 jours'),
            Text('• Historique: 5 derniers mots de passe'),
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
              print('Modifier politique');
            },
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }

  void _showSecurityAlertsDialog() {
    final alerts = [
      {'time': '02/10/2024 14:30', 'type': 'Connexion suspecte', 'ip': '192.168.1.100'},
      {'time': '01/10/2024 22:15', 'type': 'Tentative de force brute', 'ip': '203.0.113.1'},
      {'time': '01/10/2024 09:45', 'type': 'Accès non autorisé', 'ip': '198.51.100.2'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alertes de Sécurité'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: Text(alert['type']!),
                subtitle: Text('${alert['time']} - IP: ${alert['ip']}'),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showAlertsConfigDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configuration des Alertes'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Échec de connexion'),
              subtitle: Text('Seuil: 5 tentatives'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Utilisation disque'),
              subtitle: Text('Seuil: 80%'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Charge CPU'),
              subtitle: Text('Seuil: 90%'),
              value: false,
              onChanged: null,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showPerformanceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Performance Système'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Utilisation actuelle:'),
            SizedBox(height: 16),
            Text('CPU: 45% (Normal)'),
            LinearProgressIndicator(value: 0.45),
            SizedBox(height: 8),
            Text('RAM: 62% (Acceptable)'),
            LinearProgressIndicator(value: 0.62),
            SizedBox(height: 8),
            Text('Stockage: 78% (Attention)'),
            LinearProgressIndicator(value: 0.78),
            SizedBox(height: 16),
            Text('Recommandations:'),
            Text('• Envisager nettoyage disque'),
            Text('• Optimiser la base de données'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _showMaintenanceScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Maintenance Programmée'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prochaine maintenance:'),
            Text('📅 15 Octobre 2024'),
            Text('🕐 02:00 - 04:00 (GMT+1)'),
            SizedBox(height: 16),
            Text('Tâches prévues:'),
            Text('• Mise à jour sécurité'),
            Text('• Optimisation base de données'),
            Text('• Nettoyage logs'),
            Text('• Tests de performance'),
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
              print('Modifier planification');
            },
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }

  void _startDatabaseCleanup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nettoyage Base de Données'),
        content: const Text(
          'Cette opération va optimiser la base de données et peut prendre plusieurs minutes. Continuer ?'
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
                const SnackBar(
                  content: Text('Nettoyage de la base de données démarré...'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Démarrer'),
          ),
        ],
      ),
    );
  }

  void _purgeLogs() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Purger les Logs'),
        content: const Text('Supprimer les logs de plus de 30 jours ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logs purgés avec succès')),
              );
            },
            child: const Text('Purger'),
          ),
        ],
      ),
    );
  }

  void _showRestartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Redémarrer les Services'),
        content: const Text(
          'ATTENTION: Cette opération va interrompre temporairement le service. '
          'Les utilisateurs connectés seront déconnectés. Continuer ?'
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
                const SnackBar(
                  content: Text('Redémarrage des services en cours...'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Redémarrer'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'VITALIA Admin Panel',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(Icons.admin_panel_settings, size: 48, color: Colors.red.shade700),
      children: [
        const Text('Panneau d\'administration pour la gestion de la plateforme VITALIA.'),
        const SizedBox(height: 16),
        const Text('© 2024 VITALIA. Tous droits réservés.'),
        const SizedBox(height: 8),
        const Text('Support technique: admin@vitalia.com'),
      ],
    );
  }
}
