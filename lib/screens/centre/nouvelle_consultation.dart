import 'package:flutter/material.dart';

class NouvelleConsultationScreen extends StatefulWidget {
  const NouvelleConsultationScreen({Key? key}) : super(key: key);

  @override
  State<NouvelleConsultationScreen> createState() => _NouvelleConsultationScreenState();
}

class _NouvelleConsultationScreenState extends State<NouvelleConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Contrôleurs pour les champs
  final _patientController = TextEditingController();
  final _diagnosticController = TextEditingController();
  final _symptomesController = TextEditingController();
  final _examenController = TextEditingController();
  final _notesController = TextEditingController();
  final _prescriptionController = TextEditingController();
  final _prochainRdvController = TextEditingController();
  
  // Variables d'état
  String? _selectedMedecin;
  String? _selectedTypeConsultation;
  DateTime _dateConsultation = DateTime.now();
  List<Map<String, String>> _medicaments = [];
  List<String> _analyses = [];
  
  // Listes de données
  final List<String> _medecins = [
    'Dr. Martin LEROY',
    'Dr. Sophie BERNARD',
    'Dr. Paul MARTIN',
    'Dr. Anne LEFEVRE',
  ];
  
  final List<String> _typesConsultation = [
    'Consultation générale',
    'Consultation spécialisée',
    'Suivi médical',
    'Consultation d\'urgence',
    'Téléconsultation',
  ];
  
  final List<String> _analysesDisponibles = [
    'Bilan sanguin complet',
    'Glycémie',
    'Cholestérol',
    'Radiographie',
    'Échographie',
    'ECG',
    'IRM',
    'Scanner',
  ];

  @override
  void dispose() {
    _patientController.dispose();
    _diagnosticController.dispose();
    _symptomesController.dispose();
    _examenController.dispose();
    _notesController.dispose();
    _prescriptionController.dispose();
    _prochainRdvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle Consultation'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _sauvegarderBrouillon,
            child: const Text(
              'Brouillon',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionInformationsGenerales(),
            const SizedBox(height: 24),
            _buildSectionExamenClinique(),
            const SizedBox(height: 24),
            _buildSectionDiagnostic(),
            const SizedBox(height: 24),
            _buildSectionPrescription(),
            const SizedBox(height: 24),
            _buildSectionAnalyses(),
            const SizedBox(height: 24),
            _buildSectionSuivi(),
            const SizedBox(height: 32),
            _buildBoutonsSauvegarde(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionInformationsGenerales() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informations Générales',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Patient
            TextFormField(
              controller: _patientController,
              decoration: const InputDecoration(
                labelText: 'Patient *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                hintText: 'Nom ou ID VITALIA du patient',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir le nom du patient';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Médecin
            DropdownButtonFormField<String>(
              value: _selectedMedecin,
              decoration: const InputDecoration(
                labelText: 'Médecin consultant *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services),
              ),
              items: _medecins.map((medecin) {
                return DropdownMenuItem(
                  value: medecin,
                  child: Text(medecin),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMedecin = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Veuillez sélectionner un médecin';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Type de consultation
            DropdownButtonFormField<String>(
              value: _selectedTypeConsultation,
              decoration: const InputDecoration(
                labelText: 'Type de consultation *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: _typesConsultation.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTypeConsultation = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Veuillez sélectionner un type de consultation';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Date de consultation
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today),
              title: const Text('Date de consultation'),
              subtitle: Text(
                '${_dateConsultation.day}/${_dateConsultation.month}/${_dateConsultation.year} ${_dateConsultation.hour}:${_dateConsultation.minute.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.edit),
              onTap: _selectDateTime,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionExamenClinique() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Examen Clinique',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _symptomesController,
              decoration: const InputDecoration(
                labelText: 'Symptômes rapportés',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.sick),
                hintText: 'Décrivez les symptômes du patient...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _examenController,
              decoration: const InputDecoration(
                labelText: 'Observations cliniques',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.visibility),
                hintText: 'Résultats de l\'examen physique...',
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionDiagnostic() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Diagnostic',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _diagnosticController,
              decoration: const InputDecoration(
                labelText: 'Diagnostic principal *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_information),
                hintText: 'Diagnostic établi...',
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir un diagnostic';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes additionnelles',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
                hintText: 'Commentaires, recommandations...',
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionPrescription() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Prescription',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _ajouterMedicament,
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (_medicaments.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.medication, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 8),
                      Text(
                        'Aucun médicament prescrit',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              )
            else
              ..._medicaments.asMap().entries.map((entry) {
                final index = entry.key;
                final medicament = entry.value;
                return _buildMedicamentCard(medicament, index);
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicamentCard(Map<String, String> medicament, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.medication, color: Colors.white),
        ),
        title: Text(
          medicament['nom'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${medicament['dosage']} - ${medicament['frequence']}\n${medicament['duree']}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            setState(() {
              _medicaments.removeAt(index);
            });
          },
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildSectionAnalyses() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Analyses & Examens',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            const Text(
              'Sélectionnez les analyses à prescrire :',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _analysesDisponibles.map((analyse) {
                final isSelected = _analyses.contains(analyse);
                return FilterChip(
                  label: Text(analyse),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _analyses.add(analyse);
                      } else {
                        _analyses.remove(analyse);
                      }
                    });
                  },
                  selectedColor: Colors.green.shade100,
                  checkmarkColor: Colors.green.shade700,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionSuivi() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suivi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _prochainRdvController,
              decoration: const InputDecoration(
                labelText: 'Prochain rendez-vous',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.schedule),
                hintText: 'Dans 1 mois, selon résultats analyses...',
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoutonsSauvegarde() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _finaliserConsultation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Finaliser la Consultation',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _sauvegarderBrouillon,
                child: const Text('Sauvegarder en brouillon'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateConsultation,
      firstDate: DateTime.now().subtract(const Duration(days: 7)),
      lastDate: DateTime.now(),
    );
    
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dateConsultation),
      );
      
      if (pickedTime != null) {
        setState(() {
          _dateConsultation = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _ajouterMedicament() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final nomController = TextEditingController();
        final dosageController = TextEditingController();
        final frequenceController = TextEditingController();
        final dureeController = TextEditingController();
        
        return AlertDialog(
          title: const Text('Ajouter un médicament'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomController,
                  decoration: const InputDecoration(
                    labelText: 'Nom du médicament',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dosageController,
                  decoration: const InputDecoration(
                    labelText: 'Dosage (ex: 500mg)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: frequenceController,
                  decoration: const InputDecoration(
                    labelText: 'Fréquence (ex: 2 fois par jour)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dureeController,
                  decoration: const InputDecoration(
                    labelText: 'Durée (ex: 7 jours)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nomController.text.isNotEmpty) {
                  setState(() {
                    _medicaments.add({
                      'nom': nomController.text,
                      'dosage': dosageController.text,
                      'frequence': frequenceController.text,
                      'duree': dureeController.text,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _sauvegarderBrouillon() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Consultation sauvegardée en brouillon'),
        backgroundColor: Colors.orange,
      ),
    );
    print('Brouillon sauvegardé');
  }

  void _finaliserConsultation() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Consultation finalisée'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'La consultation a été enregistrée avec succès.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Le patient recevra un résumé par email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme le dialogue
                  Navigator.of(context).pop(); // Retourne au dashboard
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
