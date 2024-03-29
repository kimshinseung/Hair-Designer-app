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
  TextEditingController numberController = TextEditingController();

  String? selectedGender;
  List<String> genders = ['남','여'];

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedInfo = prefs.getStringList('userInfo') ?? [];

    if(nameController.text == "" || numberController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이름과 번호는 필수항목입니다.")),
      );
    }else{
      Map<String,String> newInfo = {
        'name' : nameController.text,
        'number' : numberController.text,
        'feature': jsonEncode({
          'feature': featureController.text,
          'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        }),
        'age' : ageController.text,
        'sex' : selectedGender ?? '안정함',
        'lastEdited' : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

      savedInfo.add(json.encode(newInfo)); //json형태로 저장
      await prefs.setStringList('userInfo', savedInfo);

      nameController.clear();
      numberController.clear();
      featureController.clear();
      ageController.clear();
      sexController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("정보가 저장되었습니다!")),
      );
      Navigator.pop(context,true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 60,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset('assets/images/logo4.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,),
              ),
              SizedBox(width: 80,),
              Text("정보 등록",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Column(
            children: [
              TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff9AACBC),)
                  ),
                  labelText: '이름',
                ),
              ),
              TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                controller: numberController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff9AACBC),)
                  ),
                  labelText: '전화번호',
                ),
              ),
              DropdownButtonFormField<String>(
                value : selectedGender,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff9AACBC),)
                    ),
                  labelText: '성별',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )
                ),
                items: genders.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
              ),
              TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                controller: ageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff9AACBC),)
                  ),
                  labelText: '나이',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                controller: featureController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff9AACBC),)
                  ),
                  labelText: '특징',
                ),
                maxLines: 5,
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: save,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0XffC2E1E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("등록하기",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
