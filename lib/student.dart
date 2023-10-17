class Student {
  int? id;
  String name;
  String grade;

  Student({this.id, required this.name, required this.grade});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
    };
  }
}
