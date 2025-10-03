import 'package:flutter/material.dart';

class ParametresCentreScreen extends StatefulWidget {
  const ParametresCentreScreen({Key? key}) : super(key: key);

  @override
  State<ParametresCentreScreen> createState() => _ParametresCentreScreenState();
}

class _ParametresCentreScreenState extends State<ParametresCentreScreen> {
  bool _notificationsNouveauxRdv = true;
  bool _notificationsAnnulations = true;
  bool _notificationsUrgences = true;
  bool _rappelsAutomatiques = true;
  bool _confirmationsSms = false;
  bool _synchronisationCalendrier = true;
  bool _accesTelemedicine = false;
  String _heureOuverture = '08:00';
  String _heureFermeture = '18:00';
  String _dureeConsultation = '30 minutes';

  final List<String> _dureeOptions = ['15 minutes', '30 minutes', '45 minutes', '60 minutes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres du Centre'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildSectionInformationsCentre(),
          _buildSectionHoraires(),
          _buildSectionNotifications(),
          _buildSectionGestionPatients(),
          _buildSectionEquipeMedicale(),
          _buildSectionFacturation(),
          _buildSectionSecurity(),
          _buildSectionSupport(),
        ],
      ),
    );
  }

  Widget _buildSectionInformationsCentre() {
    return _buildSection(
      title: 'Informations du Centre',
      icon: Icons.local_hospital,
      children: [
        ListTile(
          leading: const Icon(Icons.business),
          title: const Text('Nom du centre'),
          subtitle: const Text('Hôpital Central'),
          trailing: const Icon(Icons.edit),
          onTap: () => _showEditDialog('Nom du centre', 'Hôpital Central'),
        ),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text('Adresse'),
          subtitle: const Text('123 Rue de la Santé, Paris'),
          trailing: const Icon(Icons.edit),
          onTap: () => _showEditDialog('Adresse', '123 Rue de la Santé, Paris'),
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: const Text('Téléphone'),
          subtitle: const Text('+33 1 23 45 67 89'),
          trailing: const Icon(Icons.edit),
          onTap: () => _showEditDialog('Téléphone', '+33 1 23 45 67 89'),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Email'),
          subtitle: const Text('contact@hopital-central.fr'),
          trailing: const Icon(Icons.edit),
          onTap: () => _showEditDialog('Email', 'contact@hopital-central.fr'),
        ),
        ListTile(
          leading: const Icon(Icons.medical_services),
          title: const Text('Spécialités'),
          subtitle: const Text('Cardiologie, Médecine générale, Endocrinologie'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showSpecialitiesDialog(),
        ),
      ],
    );
  }

  Widget _buildSectionHoraires() {
    return _buildSection(
      title: 'Horaires & Planning',
      icon: Icons.schedule,
      children: [
        ListTile(
          leading: const Icon(Icons.access_time),
          title: const Text('Horaires d\'ouverture'),
          subtitle: Text('$_heureOuverture - $_heureFermeture'),
          trailing: const Icon(Icons.edit),
          onTap: () => _showHorairesDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.timer),
          title: const Text('Durée consultation par défaut'),
          subtitle: Text(_dureeConsultation),
          trailing: const Icon(Icons.edit),
          onTap: () => _showDureeDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.calendar_view_week),
          title: const Text('Jours d\'ouverture'),
          subtitle: const Text('Lundi - Vendredi'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showJoursDialog(),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.sync),
          title: const Text('Synchronisation calendrier'),
          subtitle: const Text('Sync avec Google Calendar/Outlook'),
          value: _synchronisationCalendrier,
          onChanged: (value) {
            setState(() {
              _synchronisationCalendrier = value;
            });
          },
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
          secondary: const Icon(Icons.new_releases),
          title: const Text('Nouveaux rendez-vous'),
          subtitle: const Text('Notification immédiate'),
          value: _notificationsNouveauxRdv,
          onChanged: (value) {
            setState(() {
              _notificationsNouveauxRdv = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.cancel),
          title: const Text('Annulations'),
          subtitle: const Text('Quand un patient annule'),
          value: _notificationsAnnulations,
          onChanged: (value) {
            setState(() {
              _notificationsAnnulations = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.emergency),
          title: const Text('Urgences'),
          subtitle: const Text('Consultations urgentes'),
          value: _notificationsUrgences,
          onChanged: (value) {
            setState(() {
              _notificationsUrgences = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.schedule_send),
          title: const Text('Rappels automatiques'),
          subtitle: const Text('Rappels aux patients 24h avant'),
          value: _rappelsAutomatiques,
          onChanged: (value) {
            setState(() {
              _rappelsAutomatiques = value;
            });
          },
        ),
        SwitchListTile(
          secondary: const Icon(Icons.sms),
          title: const Text('Confirmations SMS'),
          subtitle: const Text('SMS de confirmation aux patients'),
          value: _confirmationsSms,
          onChanged: (value) {
            setState(() {
              _confirmationsSms = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSectionGestionPatients() {
    return _buildSection(
      title: 'Gestion des Patients',
      icon: Icons.people,
      children: [
        ListTile(
          leading: const Icon(Icons.person_add),
          title: const Text('Nouveau patient'),
          subtitle: const Text('Processus d\'inscription'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Configuration nouveau patient'),
        ),
        ListTile(
          leading: const Icon(Icons.file_copy),
          title: const Text('Modèles de documents'),
          subtitle: const Text('Ordonnances, certificats, etc.'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Modèles documents'),
        ),
        ListTile(
          leading: const Icon(Icons.backup),
          title: const Text('Sauvegarde des données'),
          subtitle: const Text('Automatique tous les jours à 02:00'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showBackupDialog(),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.video_call),
          title: const Text('Télémédecine'),
          subtitle: const Text('Consultations à distance'),
          value: _accesTelemedicine,
          onChanged: (value) {
            setState(() {
              _accesTelemedicine = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSectionEquipeMedicale() {
    return _buildSection(
      title: 'Équipe Médicale',
      icon: Icons.medical_services,
      children: [
        ListTile(
          leading: const Icon(Icons.person_add),
          title: const Text('Ajouter un médecin'),
          subtitle: const Text('Nouveau membre de l\'équipe'),
          trailing: const Icon(Icons.add),
          onTap: () => _showAddDoctorDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.group),
          title: const Text('Gérer l\'équipe'),
          subtitle: const Text('Permissions et spécialités'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Gérer équipe'),
        ),
        ListTile(
          leading: const Icon(Icons.schedule),
          title: const Text('Planning médecins'),
          subtitle: const Text('Horaires et disponibilités'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Planning médecins'),
        ),
      ],
    );
  }

  Widget _buildSectionFacturation() {
    return _buildSection(
      title: 'Facturation',
      icon: Icons.receipt,
      children: [
        ListTile(
          leading: const Icon(Icons.price_change),
          title: const Text('Tarifs des consultations'),
          subtitle: const Text('Gérer les prix par spécialité'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showTarifsDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Moyens de paiement'),
          subtitle: const Text('CB, espèces, chèques, virements'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Moyens paiement'),
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Modèles de factures'),
          subtitle: const Text('Personnaliser vos factures'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Modèles factures'),
        ),
        ListTile(
          leading: const Icon(Icons.analytics),
          title: const Text('Rapports financiers'),
          subtitle: const Text('Chiffre d\'affaires, statistiques'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Rapports financiers'),
        ),
      ],
    );
  }

  Widget _buildSectionSecurity() {
    return _buildSection(
      title: 'Sécurité',
      icon: Icons.security,
      children: [
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Changer le mot de passe'),
          subtitle: const Text('Sécuriser votre compte'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showChangePasswordDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.vpn_key),
          title: const Text('Authentification à deux facteurs'),
          subtitle: const Text('Sécurité renforcée'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('2FA'),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Journal d\'activité'),
          subtitle: const Text('Historique des connexions'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Journal activité'),
        ),
        ListTile(
          leading: const Icon(Icons.shield),
          title: const Text('Conformité RGPD'),
          subtitle: const Text('Gestion des données personnelles'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('RGPD'),
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
          title: const Text('Documentation'),
          subtitle: const Text('Guides d\'utilisation'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Documentation'),
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          title: const Text('Support technique'),
          subtitle: const Text('Assistance 24h/24'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Support technique'),
        ),
        ListTile(
          leading: const Icon(Icons.update),
          title: const Text('Mises à jour'),
          subtitle: const Text('Dernière version: 1.0.0'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Mises à jour'),
        ),
        ListTile(
          leading: const Icon(Icons.bug_report),
          title: const Text('Signaler un problème'),
          subtitle: const Text('Rapporter un bug'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => print('Signaler problème'),
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
              Icon(icon, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
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

  void _showEditDialog(String title, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Modifier $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            border: const OutlineInputBorder(),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title modifié avec succès')),
              );
            },
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
  }

  void _showSpecialitiesDialog() {
    final specialites = [
      'Médecine générale',
      'Cardiologie',
      'Endocrinologie',
      'Dermatologie',
      'Gynécologie',
      'Pédiatrie',
      'Ophtalmologie',
      'Pneumologie',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Spécialités du centre'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: specialites.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(specialites[index]),
                value: index < 3, // Les 3 premières sont cochées par défaut
                onChanged: (value) {
                  // Logique de mise à jour
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

  void _showHorairesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Horaires d\'ouverture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Heure d\'ouverture'),
              subtitle: Text(_heureOuverture),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: int.parse(_heureOuverture.split(':')[0]),
                    minute: int.parse(_heureOuverture.split(':')[1]),
                  ),
                );
                if (time != null) {
                  setState(() {
                    _heureOuverture = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                  });
                }
              },
            ),
            ListTile(
              title: const Text('Heure de fermeture'),
              subtitle: Text(_heureFermeture),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: int.parse(_heureFermeture.split(':')[0]),
                    minute: int.parse(_heureFermeture.split(':')[1]),
                  ),
                );
                if (time != null) {
                  setState(() {
                    _heureFermeture = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                  });
                }
              },
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

  void _showDureeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Durée consultation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _dureeOptions.map((duree) {
            return RadioListTile<String>(
              title: Text(duree),
              value: duree,
              groupValue: _dureeConsultation,
              onChanged: (value) {
                setState(() {
                  _dureeConsultation = value!;
                });
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showJoursDialog() {
    final jours = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Jours d\'ouverture'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: jours.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(jours[index]),
                value: index < 5, // Lun-Ven cochés par défaut
                onChanged: (value) {
                  // Logique de mise à jour
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

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configuration sauvegarde'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fréquence: Quotidienne'),
            SizedBox(height: 8),
            Text('Heure: 02:00'),
            SizedBox(height: 8),
            Text('Rétention: 30 jours'),
            SizedBox(height: 8),
            Text('Dernière sauvegarde: Aujourd\'hui 02:00'),
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
                const SnackBar(content: Text('Sauvegarde manuelle démarrée')),
              );
            },
            child: const Text('Sauvegarder maintenant'),
          ),
        ],
      ),
    );
  }

  void _showAddDoctorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un médecin'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nom complet',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Spécialité',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
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
                const SnackBar(content: Text('Médecin ajouté avec succès')),
              );
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showTarifsDialog() {
    final tarifs = [
      {'specialite': 'Médecine générale', 'prix': '25€'},
      {'specialite': 'Cardiologie', 'prix': '50€'},
      {'specialite': 'Endocrinologie', 'prix': '45€'},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tarifs des consultations'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: tarifs.length,
            itemBuilder: (context, index) {
              final tarif = tarifs[index];
              return ListTile(
                title: Text(tarif['specialite']!),
                trailing: Text(tarif['prix']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  // Modifier le tarif
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

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer le mot de passe'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe actuel',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
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
}
