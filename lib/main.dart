import 'package:flutter/material.dart';
import 'package:hairapp/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug표시 없애기
      home:  HomeScreen(
      ),
    );
  }
}
