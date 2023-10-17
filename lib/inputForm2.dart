// ignore_for_file: unused_import, camel_case_types, must_be_immutable, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:portfolio_app/about.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';

class inputForm2 extends StatefulWidget {
  String email;

  inputForm2({required this.email});

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<inputForm2> {
  late String email;
  String? imageUrl;
  bool react = true;
  bool javascript = true;
  bool python = true;
  bool typescript = true;
  bool html = true;
  bool java = true;
  bool css = true;
  bool isloading = false;
  final ImagePicker picker = ImagePicker();
  final _firebaseStorage = FirebaseStorage.instance;
  XFile? image;

  Future getImage(ImageSource source) async {
    try {
      var img = await picker.pickImage(source: source);
      final path = '${img!.name}';
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + "-" + path;
      File imageFile = File(img.path);
      setState(() {
        isloading = true;
      });

      final ref = _firebaseStorage.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() {
        setState(() {
          isloading = false;
        });
      });

      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        image = img;
        imageUrl = downloadUrl;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Welcome to Talent Hub',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please Select Your Skills',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            CheckboxListTile(
              title: const Text('React', style: TextStyle(color: Colors.white)),
              value: react,
              onChanged: (bool? value) {
                setState(() {
                  react = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('JavaScript',
                  style: TextStyle(color: Colors.white)),
              value: javascript,
              onChanged: (bool? value) {
                setState(() {
                  javascript = value!;
                });
              },
            ),
            CheckboxListTile(
              title:
                  const Text('Python', style: TextStyle(color: Colors.white)),
              value: python,
              onChanged: (bool? value) {
                setState(() {
                  python = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('TypeScript',
                  style: TextStyle(color: Colors.white)),
              value: typescript,
              onChanged: (bool? value) {
                setState(() {
                  typescript = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('HTML', style: TextStyle(color: Colors.white)),
              value: html,
              onChanged: (bool? value) {
                setState(() {
                  html = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Java', style: TextStyle(color: Colors.white)),
              value: java,
              onChanged: (bool? value) {
                setState(() {
                  java = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('CSS', style: TextStyle(color: Colors.white)),
              value: css,
              onChanged: (bool? value) {
                setState(() {
                  css = value!;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showMediaSelectionDialog();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
              ),
              child: isloading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    )
                  : Text(
                      'Upload Photo',
                      style: TextStyle(color: Colors.black),
                    ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _navigateToAboutScreen();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
              ),
              child: Text(
                'Generate',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMediaSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(Icons.image),
                    SizedBox(width: 10.0),
                    Text('From Gallery'),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(width: 10.0),
                    Text('From Camera'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToAboutScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => About(
          email: widget.email,
          imageUrl: imageUrl!,
          react: react,
          python: python,
          html: html,
          typescript: typescript,
          javascript: javascript,
          java: java,
          css: css,
        ),
      ),
    );
  }
}
