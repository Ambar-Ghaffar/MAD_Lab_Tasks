// ignore_for_file: unused_import, unused_local_variable, body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/firebase_auth.dart';
import 'package:portfolio_app/home.dart';
import 'package:portfolio_app/input_form.dart';
import 'package:portfolio_app/registration.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final _formkey = GlobalKey<FormState>();
    final AuthService authService = AuthService();
    TextEditingController emailCont = TextEditingController();
    TextEditingController passCont = TextEditingController();

    signIn() async {
      try {
        final User? user = await authService.signIn(
          emailCont.text,
          passCont.text,
        );

        if (user != null) {
          final userDetails = await authService.getUserDetails(user.email!);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => InputForm(
                email: emailCont.text,
              ),
            ),
          );
        } else {
          // Handle the case where the user does not exist or credentials are incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                  "Invalid credentials. Please check your email and password.",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.yellow),
          );
        }
      } catch (e) {
        // Handle other exceptions (e.g., network issues)
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred. Please try again later.",
              style: TextStyle(color: Colors.black),
              // Set the text color to black
            ),
            backgroundColor: Colors.yellow,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: screenWidth < 600 ? screenWidth : 600, // Responsive width
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo.png', // Replace with your image asset path
                      width: 250, // Adjust the width as needed
                      height: 250, // Adjust the height as needed
                    ),
                    const SizedBox(
                      height: 50,
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
                          return 'Please enter some value';
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
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
                          return 'Please enter some value';
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              signIn();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16), // Button padding
                            backgroundColor: Colors.yellow,
                            foregroundColor:
                                Colors.black, // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16), // Button padding
                            backgroundColor: Colors.yellow,
                            foregroundColor:
                                Colors.black, // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
