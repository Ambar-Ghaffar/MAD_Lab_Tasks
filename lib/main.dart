// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio_app/firebase_options.dart';
import 'package:portfolio_app/get_started.dart';
import 'package:portfolio_app/home.dart';
import 'package:portfolio_app/input_form.dart';
import 'package:portfolio_app/login.dart';
import 'package:portfolio_app/registration.dart'; // Import Firebase core

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run your app
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'get_started',
    routes: {
      'get_started': (context) => TalentHubApp(),
      'login': (context) => LoginPage(),
      'registration': (context) => RegistrationScreen(),
    },
  ));
}
