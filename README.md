VITALIA - Documentation Complète
📋 TABLE DES MATIÈRES

    Description du Projet

    Architecture Technique

    Installation & Déploiement

    Fonctionnalités par Profil

    Structure du Code

    Dépendances & Configuration

    Dépannage

🏥 DESCRIPTION DU PROJET

VITALIA est une application mobile de carnet de soin numérique complète qui digitalise l'écosystème médical en connectant trois acteurs principaux :

Patients : Gestion de leur santé au quotidien
Centres de Santé : Optimisation de leur pratique médicale
Administrateurs : Supervision de la plateforme

Objectif : Créer un écosystème médical digital sécurisé, intuitif et accessible.

🏗️ ARCHITECTURE TECHNIQUE
Stack Technique

    Framework : Flutter 3.19+

    Langage : Dart 2.19+

    Backend : Firebase (Auth, Firestore)

    Build Tool : Gradle 7.3+

vitalia/
├── android/                 # Configuration Android
├── lib/
│   ├── screens/            # Écrans de l'application
│   │   ├── admin/          # Interface administrateur
│   │   ├── auth/           # Authentification
│   │   ├── centre/         # Espace centre de santé
│   │   ├── patient/        # Espace patient
│   │   └── services/       # Configuration
│   ├── main.dart           # Point d'entrée
│   └── pubspec.yaml        # Dépendances
└── build/                  # Fichiers de build

🚀 INSTALLATION & DÉPLOIEMENT
Prérequis Obligatoires
bash

# Vérifier l'installation
flutter doctor

Installation Pas à Pas
bash

# 1. Cloner le projet
git clone [https://github.com/RonhelAsg/VITALIA.git]
cd vitalia

# 2. Installer les dépendances
flutter pub get

# 3. Lancer en développement
flutter run

# 4. Build pour production
flutter build apk --release

Configuration Firebase

    Créer un projet sur Firebase Console

    Télécharger google-services.json dans android/app/

    Activer Authentication (Phone) et Firestore

Génération d'APK
bash

# Debug (test)
flutter build apk --debug

# Release (distribution)
flutter build apk --release

👥 FONCTIONNALITÉS PAR PROFIL
PATIENTS

    Dossier médical : Gestion complète du profil santé

    Prise de RDV : Réservation en ligne

    Historique : Consultations et traitements

    Recherche centres : Géolocalisation et filtres

    Auth SMS : Vérification par téléphone

CENTRES DE SANTÉ

    Gestion patients : Dossiers médicaux

    Planning : Calendrier des consultations

    Nouvelle consultation : Création de fiches

    Dashboard : Statistiques d'activité

    Auth Email : Connexion sécurisée

ADMINISTRATEURS

    Dashboard : Statistiques globales

    Gestion utilisateurs : CRUD complet

    Gestion centres : Approbation et suivi

    Paramètres : Configuration plateforme

💻 STRUCTURE DU CODE
Navigation Principale
text

SplashScreen() → FirstPage() → Choix profil → Connexion → Dashboard

Routes Principales

    /patient/dashboard

    /centre/dashboard

    /admin/dashboard

    /auth/login_patient

    /auth/login_center

    /auth/login_admin

Écrans Clés

Administration

    dashboard.dart : Vue d'ensemble avec statistiques

    gestion_utilisateurs.dart : CRUD utilisateurs avec filtres

    gestion_centres.dart : Gestion centres avec approbation

    parametres.dart : Configuration système

Authentification

    login_patient.dart : Auth par SMS (Firebase)

    login_center.dart : Auth par email

    login_admin.dart : Auth admin

Centre de Santé

    dashboard_center.dart : Activité du centre

    dossiers_patients.dart : Gestion patients

    nouvelle_consultation.dart : Création consultation

    planning.dart : Calendrier RDV

Patient

    dashboard_patient.dart : Vue patient

    dossier_medical.dart : Dossier santé

    prise_rdv.dart : Réservation

    historique_consultation.dart : Historique

📦 DÉPENDANCES & CONFIGURATION
Dépendances Principales
yaml

dependencies:
flutter:
sdk: flutter

# Firebase
firebase_core: ^2.24.0
firebase_auth: ^4.14.0
cloud_firestore: ^4.13.0

# UI & UX
country_picker: ^3.0.0
provider: ^6.1.1

Configuration Android
gradle

android {
namespace "com.ronhel.imdf.vitalia.vitalia"
compileSdk 34
minSdk 23
targetSdk 34

    buildTypes {
        release {
            signingConfig signingConfigs.debug
            minifyEnabled false
        }
    }
}

🔧 DÉPANNAGE
Erreurs Courantes

Build Gradle échoue
bash

flutter clean
rm -rf ~/.gradle/caches/
flutter pub get
cd android && ./gradlew clean && cd ..

Problème SSL/Network
bash

# Changer de réseau ou utiliser 4G
flutter build apk --debug

Firebase non configuré
bash

# Vérifier la configuration
flutterfire configure

APK ne s'installe pas

    Activer "Sources inconnues" dans Paramètres Android

    Vérifier que l'APK est signé

Commandes Utiles
bash

# Analyser le code
flutter analyze

# Nettoyer le projet
flutter clean

# Vérifier la santé
flutter doctor

🎯 COMPTES DE TEST

Patient

    ID VITALIA : PAT-001

    Téléphone : 612345678

    Code OTP : 123456 (mode test)

Centre de Santé

    ID VITALIA : CENT-001

    Email : centre@test.com

Administrateur

    Email : admin@vitalia.com

Documentation VITALIA - Version 1.0
Application de gestion médicale numérique
