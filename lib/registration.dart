// ignore_for_file: unused_import, use_build_context_synchronously, prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/firebase_auth.dart';
import 'package:portfolio_app/home.dart';
import 'package:portfolio_app/input_form.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  signUp() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCont.text,
        password: passCont.text,
      );

      if (userCredential.user != null) {
        // Registration successful, proceed with saving data to Firestore
        users.add({
          "name": nameCont.text,
          "email": emailCont.text,
          "password": passCont.text,
        });

        final userDetails = {
          "name": nameCont.text,
          "email": emailCont.text,
          "password": passCont.text,
        };

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InputForm(
              email: emailCont.text,
            ),
          ),
        );
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Email is already in use. Please use a different email.",style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.yellow,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registration failed. Please try again.",style: TextStyle(color: Colors.black),),
              backgroundColor: Colors.yellow,
            ),
          );
        }
      } else {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png', // Replace with your image asset path
                    width: 250, // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: nameCont,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      icon: Icon(
                        Icons.account_box,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailCont,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passCont,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      icon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16), // Button padding
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black, // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      signUp();
    }
  }
}
