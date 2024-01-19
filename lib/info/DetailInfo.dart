import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairapp/info/DetailFeature.dart';
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
  late TextEditingController newFeatureController;
  late List<Map<String, String>> featureList;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData['name']);
    numberController = TextEditingController(text: widget.userData['number']);
    sexController = TextEditingController(text: widget.userData['sex']);
    ageController = TextEditingController(text: widget.userData['age']);
    featureController = TextEditingController(text: widget.userData['feature']);
    lastModified = TextEditingController(text: widget.userData['lastEdited']);
    newFeatureController = TextEditingController();

    // JSON 문자열을 파싱하여 featureList를 복원
    String featuresJson = widget.userData['feature'] ?? '[]';
    var decodedData = jsonDecode(featuresJson);
    print(decodedData);
    if (decodedData is List) {
      featureList = decodedData.map((item) {
        if (item is Map<String, dynamic>) {
          return {
            'feature': item['feature']?.toString() ?? '',
            'date': item['date']?.toString() ?? '',
          };
        }
        return {'feature': '', 'date': ''}; // 오류 처리 또는 다른 로직
      }).toList();
    } else {
      featureList = [];
      // 오류 처리 또는 다른 로직
    }
  }



  void saveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedInfo = prefs.getStringList('userInfo') ?? [];

    String featuresJson = jsonEncode(featureList.map((feature) => {
      'feature': feature['feature'],
      'date': feature['date']
    }).toList());

    Map<String, String> updatedInfo = {
      'name': nameController.text,
      'number': numberController.text,
      'sex': sexController.text,
      'age': ageController.text,
      'feature': featuresJson,
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
      }
    }

    if(indexUpdate != -1) {
      savedInfo[indexUpdate] = json.encode(updatedInfo);
    } else {
    }

    // Save features to SharedPreferences
    List<String> updatedFeatures = prefs.getStringList('features') ?? [];
    updatedFeatures.add(featureController.text);
    prefs.setStringList('features', updatedFeatures);
    print(updatedFeatures);

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
                  fontSize: 35,
                )
            ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("이름:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    controller: nameController,
                    decoration: InputDecoration(
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
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 22,

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
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 22,

                    ),
                    controller: sexController,
                    decoration: InputDecoration(
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
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    style: TextStyle(
                        fontSize: 22,
                    ),
                    controller: ageController,
                    decoration: InputDecoration(
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
                      fontWeight: FontWeight.bold,
                      fontSize: 20,),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    height: 170, // 이 부분의 높이를 조절하여 특징 목록의 크기를 설정합니다.
                    child: SingleChildScrollView(
                      child: Column(
                        children: featureList.map((map) {
                          int index = featureList.indexOf(map);
                          return ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailFeature(featureData: map,),),);
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    map['feature']!,
                                    style: TextStyle(fontSize: 22,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  map['date']!, // 여기에 날짜를 표시
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  featureList.removeAt(index);
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                    child: Text("특징 추가 :",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),)),
                Expanded(
                  flex: 8,
                    child: TextField(
                      controller: newFeatureController,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 3,
                ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.add_circle, size: 40),
                    onPressed: () {
                      setState(() {
                        String newFeature = newFeatureController.text.trim();
                        if (newFeature.isNotEmpty) {
                          featureList.add({
                            'feature': newFeature,
                            'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          });
                          newFeatureController.clear();
                        }
                      });
                      print(featureList);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text('최근 방문 날짜: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(lastModified.text))}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),),
              ],
            ),
            SizedBox(height: 10,),
            Center(child: ElevatedButton(onPressed:
            saveChanges, child: Text('수정완료',style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),),))
          ],
        ),
      ),
    );
  }
}
