import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqlite_task/dbhelper.dart';
import 'package:sqlite_task/student.dart';

class SearchStudentsScreen extends StatefulWidget {
  @override
  _SearchStudentsScreenState createState() => _SearchStudentsScreenState();
}

class _SearchStudentsScreenState extends State<SearchStudentsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Student> searchResults = [];

  Future<void> _searchStudents() async {
    final query = searchController.text.trim();
    if (query.isNotEmpty) {
      final results = await DatabaseHelper().searchStudents(query);
      setState(() {
        searchResults = results;
      });
    } else {
      setState(() {
        searchResults.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchStudents,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (ctx, index) {
                  final student = searchResults[index];
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text(student.grade),
                    onTap: () {
                      // Implement navigation to view/edit student screen
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
