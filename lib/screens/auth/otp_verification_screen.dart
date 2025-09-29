import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String verificationId;
  final String phoneNumber;
  final String vitaliaId;

  const OtpVerificationScreen({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
    required this.vitaliaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vérification OTP')),
      body: const Center(
        child: Text('Écran de vérification OTP - À compléter'),
      ),
    );
  }
}