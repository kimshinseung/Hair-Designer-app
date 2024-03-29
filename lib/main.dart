import 'package:flutter/material.dart';
import'package:hairapp/caculator/caculator.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';
import 'caculator/Model.dart';
import 'caculator/caculator.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시

void main() {
  runApp(const MyApp());
  // runApp( //계산기
  //   MultiProvider
  //     (
  //     providers: [ChangeNotifierProvider(create: (_) => DisplayNumValue()),],
  //     child: CalculatorApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'gyuri'),
      debugShowCheckedModeBanner: false, //debug표시 없애기
      home:  HomeScreen(
      ),
    );
  }
}
