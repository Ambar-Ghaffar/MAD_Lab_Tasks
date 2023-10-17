import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_task/home.dart';
import 'package:provider_task/proider.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => CartProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shopping Cart App', home: MyHomePage());
  }
}