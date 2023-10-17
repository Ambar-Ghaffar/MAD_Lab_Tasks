import 'package:chat_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  MyApp({Key?key}):super(key: key);

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Whats App",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ), 
      home: HomeScreen(),     
    );
  }
}