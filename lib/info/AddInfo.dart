import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시
class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {

  TextEditingController nameController = TextEditingController();
  TextEditingController featureController = TextEditingController();
  String name = "";
  String feature = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset('assets/images/logo.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,),
              ),
              SizedBox(width: 70,),
              Text("정보 등록",style: TextStyle(
                fontSize: 25,
              ),
              ),
            ],
          ),
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이름',
                ),
                onChanged: (value){
                  setState(() {
                    name = value;
                  });
                },
              ),
              TextField(
                controller: featureController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '특징',
                ),
                maxLines: 3,
                onChanged: (value){
                  setState(() {
                    feature = value;
                  });
                },
              ),
              ElevatedButton(onPressed: (){}, child: Text("등록하기")),
            ],
          )
        ],
      ),
    );
  }
}
