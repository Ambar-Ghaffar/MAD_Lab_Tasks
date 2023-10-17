import 'package:flutter/material.dart';
import 'package:sqlite_task/dbhelper.dart';
import 'package:sqlite_task/student.dart';


class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  Future<void> _addStudent() async {
    final name = nameController.text.trim();
    final grade = gradeController.text.trim();

    if (name.isNotEmpty && grade.isNotEmpty) {
      final student = Student(name: name, grade: grade);
      await DatabaseHelper().insertStudent(student);
      Navigator.pop(context); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
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
              onPressed: _addStudent,
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
