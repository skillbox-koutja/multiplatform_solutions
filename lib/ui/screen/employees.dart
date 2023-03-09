import 'dart:convert';

import 'package:flutter/services.dart';

class Employee {
  static const empty = Employee(
    id: 1,
    firstName: 'Foo',
    lastName: 'Bar',
    email: 'foo@bar.com',
  );

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  String get name => '$firstName $lastName';
  String get initials => '${firstName[0]}${lastName[0]}';

  const Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Employee.fromMap(Map<String, dynamic> data) {
    return Employee(
      id: data['id'] as int,
      firstName: data['first_name'] as String,
      lastName: data['last_name'] as String,
      email: data['email'] as String,
    );
  }
}

class Employees {
  Future<List<Employee>> get() async {
    final data = await _fetchJsonFromAssetsFile('assets/employees.json');
    final employees = data['employees'] as List<dynamic>;

    return employees.map((dynamic jsonData) => Employee.fromMap(jsonData as Map<String, dynamic>)).toList();
  }
}

Future<Map<String, dynamic>> _fetchJsonFromAssetsFile(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then<Map<String, dynamic>>((jsonStr) => jsonDecode(jsonStr) as Map<String, dynamic>);
}
