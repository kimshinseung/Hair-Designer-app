import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, //음영 제거
        centerTitle: true, //가운데정렬
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text("디자이너 전용 계산기"
          ,style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>
        [
          Container(
          )
        ],
      ),
    );
  }
}
