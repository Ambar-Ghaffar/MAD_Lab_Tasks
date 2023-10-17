
import 'package:flutter/material.dart';

class TalentHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TalentHub',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.yellow, // Change the color to blue
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Make your portfolio',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              Image.asset(
                'logo.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              SizedBox(height: 20.0),
              Text(
                'Best solution to showcase your skills',
                style: TextStyle(
                  fontSize: 18.0, // Increase font size
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  onPrimary: Colors.black,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold, // Bold the text
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
