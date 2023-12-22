import 'package:flutter/material.dart';

String searchText = '';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80,),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '이름을 입력해주세요.',
                border: OutlineInputBorder(),
              ),

            ),
          ),
          Column(
            children: [
              Text("aaaa",style: TextStyle(fontSize: 40),),

            ],
          )
        ],
      ),
    );
  }
}