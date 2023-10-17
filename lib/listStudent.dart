import 'package:flutter/material.dart';
import 'package:sqlite_task/dbhelper.dart';
import 'package:sqlite_task/editStudent.dart';
import 'package:sqlite_task/student.dart';


class ListStudentsScreen extends StatefulWidget {
  const ListStudentsScreen({super.key});

  @override
  _ListStudentsScreenState createState() => _ListStudentsScreenState();
}

class _ListStudentsScreenState extends State<ListStudentsScreen> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final loadedStudents = await DatabaseHelper().getAllStudents();
    setState(() {
      students = loadedStudents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (ctx, index) {
          final student = students[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text(student.grade),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await DatabaseHelper().deleteStudent(student.id!);
                _loadStudents();
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditStudentScreen(student: student),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
