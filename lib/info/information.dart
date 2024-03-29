import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairapp/info/AddInfo.dart';
import 'package:hairapp/info/DetailInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding and decoding
// ignore_for_file: prefer_const_constructors
// const 상수 무시
class information extends StatefulWidget {
  @override
  State<information> createState() => _informationState();
}

class _informationState extends State<information> {

  List<Map<String, String>> userInfo = [];

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }
  void onDestory() {
    Navigator.pop(context);
  }

  void updateUserInfo() async {
    await loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedInfo = prefs.getStringList('userInfo') ?? [];

    List<Map<String, String>> loadedInfo = [];

    for (var info in savedInfo) {
      var decoded = json.decode(info);
      if (decoded is Map<String, dynamic>) {
        // Convert to Map<String, String> and add to loadedInfo
        loadedInfo.add(decoded.map((key, value) => MapEntry(key, value.toString())));
      }
    }
    setState(() {
      userInfo = loadedInfo;
    });
    print(userInfo);
  }


  void addInfo() {
    setState(() {
    });
  }
  Future<void> showOptionsDialog(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('설정',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('보기 및 수정',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailInfo(userData: userInfo[index]),
                    ),
                  ).then((value) {
                    if(value == true){
                      updateUserInfo();
                    }
                  });
                },
              ),
              ListTile(
                title: Text('삭제',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
                onTap: () {
                  setState(() {
                    userInfo.removeAt(index); // Remove the item
                  });
                  saveUserInfo(); // Save the updated list
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> saveUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedInfo = userInfo.map((info) {
      return json.encode(info);
    }).toList();

    await prefs.setStringList('userInfo', encodedInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset('assets/images/logo4.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: IconButton(onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddInfo())).
                  then((value) {
                    //화면으로 돌아오면 업데이트한다.
                    if(value == true) {
                      updateUserInfo();
                    }
                  });
                }, icon: Icon(Icons.add_box_rounded,size: 40,color: Color(0XffC2E1E7),)),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: userInfo.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('이름: ${userInfo[index]['name']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),),
                      Text('번호: ${userInfo[index]['number']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),),
                      Text('성별: ${userInfo[index]['sex']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),),
                    ],
                  ),
                  onTap: () {
                    showOptionsDialog(index);
                  },
                );
              }, separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )
        ],
      )
    );
  }
}
