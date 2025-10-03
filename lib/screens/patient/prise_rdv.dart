import 'package:flutter/material.dart';

class PriseRdvScreen extends StatefulWidget {
  const PriseRdvScreen({Key? key}) : super(key: key);

  @override
  State<PriseRdvScreen> createState() => _PriseRdvScreenState();
}

class _PriseRdvScreenState extends State<PriseRdvScreen> {
  int _currentStep = 0;
  String? _selectedCentre;
  String? _selectedSpecialite;
  String? _selectedMedecin;
  DateTime? _selectedDate;
  String? _selectedHeure;
  String _motifConsultation = '';

  final List<Map<String, dynamic>> _centres = [
    {
      'id': 'CENT-001',
      'nom': 'Hôpital Central',
      'adresse': '123 Rue de la Santé, Paris',
      'distance': '2.5 km',
      'note': 4.8,
      'specialites': ['Cardiologie', 'Médecine Générale', 'Endocrinologie', 'Dermatologie'],
    },
    {
      'id': 'CENT-002',
      'nom': 'Clinique Sainte-Marie',
      'adresse': '45 Avenue des Roses, Paris',
      'distance': '3.2 km',
      'note': 4.6,
      'specialites': ['Médecine Générale', 'Gynécologie', 'Pédiatrie', 'Ophtalmologie'],
    },
    {
      'id': 'CENT-003',
      'nom': 'Cabinet Médical Saint-Pierre',
      'adresse': '78 Boulevard de la République, Paris',
      'distance': '1.8 km',
      'note': 4.9,
      'specialites': ['Médecine Générale', 'Cardiologie', 'Pneumologie'],
    },
  ];

  final Map<String, List<Map<String, String>>> _medecins = {
    'Cardiologie': [
      {'nom': 'Dr. Martin LEROY', 'titre': 'Cardiologue'},
      {'nom': 'Dr. Sophie BERNARD', 'titre': 'Cardiologue'},
    ],
    'Médecine Générale': [
      {'nom': 'Dr. Paul MARTIN', 'titre': 'Médecin Généraliste'},
      {'nom': 'Dr. Claire DUPONT', 'titre': 'Médecin Généraliste'},
    ],
    'Endocrinologie': [
      {'nom': 'Dr. Anne LEFEVRE', 'titre': 'Endocrinologue'},
    ],
    'Dermatologie': [
      {'nom': 'Dr. Pierre MOREAU', 'titre': 'Dermatologue'},
    ],
  };

  final List<String> _heuresDisponibles = [
    '08:00', '08:30', '09:00', '09:30', '10:00', '10:30',
    '11:00', '11:30', '14:00', '14:30', '15:00', '15:30',
    '16:00', '16:30', '17:00', '17:30',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre Rendez-vous'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        controlsBuilder: (context, details) {
          return Row(
            children: [
              if (details.stepIndex < 4)
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(details.stepIndex == 4 ? 'Confirmer' : 'Suivant'),
                ),
              const SizedBox(width: 8),
              if (details.stepIndex > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Précédent'),
                ),
            ],
          );
        },
        onStepContinue: () {
          if (_currentStep < 4) {
            if (_validateCurrentStep()) {
              setState(() {
                _currentStep++;
              });
            }
          } else {
            _confirmerRendezVous();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
        steps: [
          _buildEtapeSelectionCentre(),
          _buildEtapeSelectionSpecialite(),
          _buildEtapeSelectionMedecin(),
          _buildEtapeSelectionDateTime(),
          _buildEtapeConfirmation(),
        ],
      ),
    );
  }

  Step _buildEtapeSelectionCentre() {
    return Step(
      title: const Text('Centre de Santé'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choisissez un centre de santé :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          ..._centres.map((centre) => _buildCentreCard(centre)),
        ],
      ),
      isActive: _currentStep >= 0,
      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
    );
  }

  Step _buildEtapeSelectionSpecialite() {
    final centreSelectionne = _centres.firstWhere((c) => c['id'] == _selectedCentre);
    final specialites = centreSelectionne['specialites'] as List<String>;

    return Step(
      title: const Text('Spécialité'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choisissez une spécialité :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          ...specialites.map((specialite) => _buildSpecialiteCard(specialite)),
        ],
      ),
      isActive: _currentStep >= 1,
      state: _currentStep > 1 ? StepState.complete : 
             _currentStep == 1 ? StepState.indexed : StepState.disabled,
    );
  }

  Step _buildEtapeSelectionMedecin() {
    final medecinsDisponibles = _medecins[_selectedSpecialite] ?? [];

    return Step(
      title: const Text('Médecin'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choisissez un médecin :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          ...medecinsDisponibles.map((medecin) => _buildMedecinCard(medecin)),
        ],
      ),
      isActive: _currentStep >= 2,
      state: _currentStep > 2 ? StepState.complete : 
             _currentStep == 2 ? StepState.indexed : StepState.disabled,
    );
  }

  Step _buildEtapeSelectionDateTime() {
    return Step(
      title: const Text('Date et Heure'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sélectionnez une date :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          _buildDateSelector(),
          const SizedBox(height: 24),
          if (_selectedDate != null) ...[
            const Text(
              'Créneaux disponibles :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _buildHeureSelector(),
          ],
          const SizedBox(height: 24),
          const Text(
            'Motif de la consultation :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Décrivez brièvement le motif de votre visite...',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _motifConsultation = value;
              });
            },
          ),
        ],
      ),
      isActive: _currentStep >= 3,
      state: _currentStep > 3 ? StepState.complete : 
             _currentStep == 3 ? StepState.indexed : StepState.disabled,
    );
  }

  Step _buildEtapeConfirmation() {
    final centre = _centres.firstWhere((c) => c['id'] == _selectedCentre);
    final medecin = _medecins[_selectedSpecialite]?.firstWhere((m) => m['nom'] == _selectedMedecin);

    return Step(
      title: const Text('Confirmation'),
      content: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Récapitulatif de votre rendez-vous :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildRecapRow('Centre', centre['nom']),
              _buildRecapRow('Adresse', centre['adresse']),
              _buildRecapRow('Spécialité', _selectedSpecialite ?? ''),
              _buildRecapRow('Médecin', medecin?['nom'] ?? ''),
              _buildRecapRow('Date', _selectedDate != null ? 
                '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' : ''),
              _buildRecapRow('Heure', _selectedHeure ?? ''),
              if (_motifConsultation.isNotEmpty)
                _buildRecapRow('Motif', _motifConsultation),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Vous recevrez une confirmation par SMS et email.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isActive: _currentStep >= 4,
      state: _currentStep == 4 ? StepState.indexed : StepState.disabled,
    );
  }

  Widget _buildCentreCard(Map<String, dynamic> centre) {
    final isSelected = _selectedCentre == centre['id'];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isSelected ? Colors.green.shade50 : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const Icon(Icons.local_hospital, color: Colors.green),
        ),
        title: Text(
          centre['nom'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.green.shade700 : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(centre['adresse']),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                Text(' ${centre['distance']}'),
                const SizedBox(width: 16),
                Icon(Icons.star, size: 16, color: Colors.orange),
                Text(' ${centre['note']}'),
              ],
            ),
          ],
        ),
        trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
        onTap: () {
          setState(() {
            _selectedCentre = centre['id'];
            _selectedSpecialite = null;
            _selectedMedecin = null;
          });
        },
        isThreeLine: true,
      ),
    );
  }

  Widget _buildSpecialiteCard(String specialite) {
    final isSelected = _selectedSpecialite == specialite;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected ? Colors.green.shade50 : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const Icon(Icons.medical_services, color: Colors.green),
        ),
        title: Text(
          specialite,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.green.shade700 : null,
          ),
        ),
        trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
        onTap: () {
          setState(() {
            _selectedSpecialite = specialite;
            _selectedMedecin = null;
          });
        },
      ),
    );
  }

  Widget _buildMedecinCard(Map<String, String> medecin) {
    final isSelected = _selectedMedecin == medecin['nom'];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected ? Colors.green.shade50 : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: Text(
            medecin['nom']!.split(' ')[1][0],
            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          medecin['nom']!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.green.shade700 : null,
          ),
        ),
        subtitle: Text(medecin['titre']!),
        trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
        onTap: () {
          setState(() {
            _selectedMedecin = medecin['nom'];
          });
        },
      ),
    );
  }

  Widget _buildDateSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedDate != null ? 
                'Date sélectionnée: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' : 
                'Aucune date sélectionnée',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _selectDate(),
                icon: const Icon(Icons.calendar_today),
                label: const Text('Choisir une date'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeureSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _heuresDisponibles.map((heure) {
        final isSelected = _selectedHeure == heure;
        return ChoiceChip(
          label: Text(heure),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedHeure = selected ? heure : null;
            });
          },
          selectedColor: Colors.green.shade100,
          labelStyle: TextStyle(
            color: isSelected ? Colors.green.shade700 : null,
            fontWeight: isSelected ? FontWeight.bold : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecapRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedHeure = null; // Reset l'heure sélectionnée
      });
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        if (_selectedCentre == null) {
          _showError('Veuillez sélectionner un centre de santé');
          return false;
        }
        break;
      case 1:
        if (_selectedSpecialite == null) {
          _showError('Veuillez sélectionner une spécialité');
          return false;
        }
        break;
      case 2:
        if (_selectedMedecin == null) {
          _showError('Veuillez sélectionner un médecin');
          return false;
        }
        break;
      case 3:
        if (_selectedDate == null) {
          _showError('Veuillez sélectionner une date');
          return false;
        }
        if (_selectedHeure == null) {
          _showError('Veuillez sélectionner un créneau horaire');
          return false;
        }
        break;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _confirmerRendezVous() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rendez-vous confirmé !'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 64),
              SizedBox(height: 16),
              Text(
                'Votre rendez-vous a été confirmé avec succès.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Vous recevrez un SMS de confirmation sous peu.',
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
