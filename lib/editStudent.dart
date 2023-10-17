import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqlite_task/dbhelper.dart';
import 'package:sqlite_task/student.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  EditStudentScreen({required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with the existing student data
    nameController.text = widget.student.name;
    gradeController.text = widget.student.grade;
  }

  Future<void> _updateStudent() async {
    final name = nameController.text.trim();
    final grade = gradeController.text.trim();

    if (name.isNotEmpty && grade.isNotEmpty) {
      widget.student.name = name;
      widget.student.grade = grade;

      await DatabaseHelper().updateStudent(widget.student);
      Navigator.pop(context); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: gradeController,
              decoration: InputDecoration(labelText: 'Grade'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateStudent,
              child: Text('Update Student'),
            ),
          ],
        ),
      ),
    );
  }
}
