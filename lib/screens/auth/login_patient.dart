import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitalia/screens/auth/otp_verification_screen.dart';

class LoginPatientScreen extends StatefulWidget {
  const LoginPatientScreen({Key? key}) : super(key: key);

  @override
  State<LoginPatientScreen> createState() => _LoginPatientScreenState();
}

class _LoginPatientScreenState extends State<LoginPatientScreen> {
  final _idController = TextEditingController();
  final _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Country _selectedCountry = Country(
    phoneCode: '33',
    countryCode: 'FR',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'France',
    example: '612345678',
    displayName: 'France',
    displayNameNoCountryCode: 'FR',
    e164Key: '',
  );

  @override
  void dispose() {
    _idController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOtpToPatient() async {
    final vitaliaId = _idController.text.trim();
    final phoneNumber = _phoneController.text.trim();
    final fullPhoneNumber = '+${_selectedCountry.phoneCode}$phoneNumber';

    if (vitaliaId.isEmpty || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. VÉRIFIER QUE L'ID VITALIA EXISTE DANS FIRESTORE
      // (À IMPLÉMENTER PLUS TARD)

      // 2. ENVOYER L'OTP AVEC FIREBASE AUTH
      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Auto-validation si le device est reconnu
          setState(() => _isLoading = false);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() => _isLoading = false);
          // Naviguer vers l'écran de vérification OTP
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpVerificationScreen(
                verificationId: verificationId,
                phoneNumber: fullPhoneNumber,
                vitaliaId: vitaliaId,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() => _isLoading = false);
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  void _formatPhoneNumber(String value) {
    // Adaptation selon la longueur typique du pays
    final maxLength = _selectedCountry.example.length;
    if (value.length > maxLength) {
      _phoneController.text = value.substring(0, maxLength);
      _phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: _phoneController.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion Patient'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_vitalia.png',
              height: 100,
            ),
            const SizedBox(height: 30),

            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'ID VITALIA',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 20),

            // Ligne pour le numéro de téléphone avec sélection du pays
            Row(
              children: [
                // Bouton de sélection du pays
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            _selectedCountry = country;
                          });
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedCountry.flagEmoji,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 8),
                          Text('+${_selectedCountry.phoneCode}'),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Champ pour le numéro de téléphone
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: _formatPhoneNumber,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.phone),
                      hintText: _selectedCountry.example,
                    ),
                  ),
                ),
              ],
            ),

            // Affichage du numéro complet
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Numéro complet: +${_selectedCountry.phoneCode}${_phoneController.text}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _isLoading ? null : _sendOtpToPatient,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                'Recevoir le code par SMS',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}