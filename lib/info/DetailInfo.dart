import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding and decoding
// ignore_for_file: prefer_const_constructors
// const 상수 무시
class DetailInfo extends StatefulWidget {
  final Map<String, String> userData;
  const DetailInfo({Key? key, required this.userData}) : super(key: key);

  @override
  State<DetailInfo> createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {

  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController sexController;
  late TextEditingController ageController;
  late TextEditingController featureController;
  late TextEditingController lastModified;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData['name']);
    numberController = TextEditingController(text: widget.userData['number']);
    sexController = TextEditingController(text: widget.userData['sex']);
    ageController = TextEditingController(text: widget.userData['age']);
    featureController = TextEditingController(text: widget.userData['feature']);
    lastModified = TextEditingController(text: widget.userData['lastEdited']);
  }

  void saveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedInfo = prefs.getStringList('userInfo') ?? [];

    Map<String, String> updatedInfo = {
      'name': nameController.text,
      'number': numberController.text,
      'sex': sexController.text,
      'age': ageController.text,
      'feature': featureController.text,
      'lastEdited' : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    };

    //수정할 아이템을 리스트에서 찾아야 함
    int indexUpdate = -1;

    for (var i = 0; i < savedInfo.length; i++) {
      try {
        Map<String, dynamic> currentItem = json.decode(savedInfo[i]);
        Map<String, String> currentItemString = currentItem.map((key, value) => MapEntry(key, value.toString()));

        //이름과 번호가 동일해야된다.
        if (currentItemString['name'] == widget.userData['name']&&
        currentItemString['number'] == widget.userData['number']) {
          indexUpdate = i;
          break;
        }
      } catch (e) {
        // Handle potential JSON decode errors
        print("Error decoding JSON: $e");
      }
    }

    if(indexUpdate != -1) {
      savedInfo[indexUpdate] = json.encode(updatedInfo);
    } else {
      print("item to update not found");
    }

    await prefs.setStringList('userInfo', savedInfo);
    await prefs.setString('lastModified', DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('수정되었습니다!')),
    );
    Navigator.pop(context,true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40,),
            Center(
              child: Text("회원 정보",style:
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )
            ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("이름:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 20
                    ),
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: '이름',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("번호:",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 20
                    ),
                    controller: numberController,
                    decoration: InputDecoration(
                      hintText: '',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("성별:",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 20
                    ),
                    controller: sexController,
                    decoration: InputDecoration(
                      hintText: '성별',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("나이:",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 20
                    ),
                    controller: ageController,
                    decoration: InputDecoration(
                      hintText: '나이',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("특징:",
                    style: TextStyle(
                      fontSize: 20,
                    ),),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 20
                    ),
                    controller: featureController,
                    decoration: InputDecoration(
                    ),
                    maxLines: 5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('최근 방문 날짜: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(lastModified.text))}',
                style: TextStyle(
                  fontSize: 15,
                ),),
              ],
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: saveChanges, child: Text('수정완료'),)
          ],
        ),
      ),
    );
  }
}
