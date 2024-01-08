import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시
class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController featureController = TextEditingController();
  TextEditingController sexController = TextEditingController();

  String? selectedGender;
  List<String> genders = ['남','여'];

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedInfo = prefs.getStringList('userInfo') ?? [];

    if(nameController.text == "" || ageController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("입력되지 않았습니다.")),
      );
    }else{
      Map<String,String> newInfo = {
        'name' : nameController.text,
        'feature' : featureController.text,
        'age' : ageController.text,
        'sex' : selectedGender ?? '안정함',
        'lastEdited' : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

      savedInfo.add(json.encode(newInfo)); //json형태로 저장
      await prefs.setStringList('userInfo', savedInfo);

      nameController.clear();
      featureController.clear();
      ageController.clear();
      sexController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("정보가 저장되었습니다!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          SizedBox(height: 30,),
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이름',
                ),
              ),
              DropdownButtonFormField<String>(
                value : selectedGender,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '성별',
                ),
                items: genders.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '나이',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: featureController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '특징',
                ),
                maxLines: 5,
              ),
              ElevatedButton(onPressed: save, child: Text("등록하기")),
            ],
          )
        ],
      ),
    );
  }
}
