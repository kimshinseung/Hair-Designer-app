import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../info/DetailInfo.dart';
import 'ImageViewer.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imagePaths = [];
  String searchText = '';
  
  //필터링할 정보들
  List<Map<String, String>> userInfo = [];
  List<Map<String, String>> filteredUserInfo = [];


  //검색결과를 overlay해서 보여준다.
  FocusNode focusNode = FocusNode();
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void showOverlay(BuildContext context) {
    overlayEntry = createOverlayEntry(context);
    Overlay.of(context)?.insert(overlayEntry!);
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  OverlayEntry createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 213,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 48), // TextField의 높이에 따라 조정
          child: Material(
            elevation: 4.0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredUserInfo.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredUserInfo[index]['name'] ?? ''),
                  onTap:() {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailInfo(userData: userInfo[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadImagePaths();
    loadUserInfo();
    focusNode.addListener(() {
      if(focusNode.hasFocus) {
        showOverlay(context);
      } else {
        removeOverlay();
      }
    });
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedInfo = prefs.getStringList('userInfo') ?? [];

    List<Map<String, String>> loadedInfo = [];

    for (var info in savedInfo) {
      var decoded = json.decode(info);
      if (decoded is Map<String, dynamic>) {
        loadedInfo.add(decoded.map((key, value) => MapEntry(key, value.toString())));
      }
    }

    setState(() {
      userInfo = loadedInfo;
      filteredUserInfo = List.from(userInfo);
    });
  }

  void onSearchTextChanged(String text) {
    setState(() {
      filteredUserInfo = userInfo
          .where((user) => user['name']!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _loadImagePaths() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedPaths = prefs.getStringList('imagePaths');
    if (savedPaths != null) {
      setState(() {
        imagePaths = savedPaths;
      });
    }
  }


  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(image != null) {
      // File imageFile = File(image.path);
      addImage(File(image.path));
    }
  }

  void addImage(File image) {
    //Widget imagewidget = Image.file(image);
    setState(() {
      imagePaths.insert(0,image.path); //여기서 사진 추가하면 됨
    });
    saveImagePaths();
  }

  Future<void> saveImagePaths() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('imagePaths', imagePaths);
  }

  Future<void> removeImagePath(int index) async {
    setState(() {
      imagePaths.removeAt(index);
    });
    saveImagePaths();
  }
  void showOptionsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('선택'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('보기'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewer(path: Image.file(File(imagePaths[index])),)),
                    );
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('삭제'),
                  onTap: () {
                    Navigator.of(context).pop();
                    removeImagePath(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset('assets/images/logo.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: IconButton(onPressed: pickImage, icon: Icon(Icons.add_box_rounded,size: 40,)),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:100,vertical: 0),
          child: CompositedTransformTarget(
            link: layerLink,
            child: TextField(
              focusNode: focusNode,
              controller: searchController,
              decoration: InputDecoration(
                hintText: '이름을 입력해주세요.',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                onSearchTextChanged(text);
                if(overlayEntry != null) {
                  removeOverlay();
                  showOverlay(context);
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 529,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              itemCount: imagePaths.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:Image.file(File(imagePaths[index])),
                  onTap: (){
                    showOptionsDialog(context, index);
                  },
                );
              }, separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          ),
        )
      ],
    );
  }
}