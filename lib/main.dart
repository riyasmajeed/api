
import 'package:apitest/view/addmore/addmore.dart';
import 'package:apitest/view/screens/Homepage.dart';
import 'package:apitest/view/screens/add.dart';
import 'package:apitest/view/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
routes:
{
  "adduser" :(BuildContext context) => Add(),
} ,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        body: const Home(),
      ),
    );
  }
}
