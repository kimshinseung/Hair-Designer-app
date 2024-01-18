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
      builder: (context) =>
          Positioned(
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
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailInfo(userData: userInfo[index]),
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
      if (focusNode.hasFocus) {
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
        loadedInfo.add(
            decoded.map((key, value) => MapEntry(key, value.toString())));
      }
    }

    setState(() {
      userInfo = loadedInfo;
      filteredUserInfo = List.from(userInfo);
    });
  }

  void onSearchTextChanged(String text) {
    setState(() {
      filteredUserInfo = userInfo.where((user) {
        String name = user['name']?.toLowerCase() ?? '';
        String number = user['number']?.toLowerCase() ?? '';
        String searchTextLower = text.toLowerCase();

        return name.contains(searchTextLower) ||
            number.contains(searchTextLower);
      }).toList();
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

    if (image != null) {
      // File imageFile = File(image.path);
      addImage(File(image.path));
    }
  }

  void addImage(File image) {
    //Widget imagewidget = Image.file(image);
    setState(() {
      imagePaths.insert(0, image.path); //여기서 사진 추가하면 됨
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
                  child: Text('보기',style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageViewer(path: Image.file(
                                  File(imagePaths[index])),)),
                    );
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('삭제',style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
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
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                'assets/images/logo4.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CompositedTransformTarget(
                  link: layerLink,
                  child: TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    focusNode: focusNode,
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: '이름을 입력해주세요.',suffixStyle: TextStyle(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder( // 기본 상태의 테두리 색상
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Color(0XffC2E1E7)),
                      ),
                      focusedBorder: OutlineInputBorder( // 포커스 됐을 때의 테두리 색상
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Color(0XffC2E1E7)),
                      ),
                    ),
                    onChanged: (text) {
                      onSearchTextChanged(text);
                      if (overlayEntry != null) {
                        removeOverlay();
                        showOverlay(context);
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: IconButton(
                onPressed: pickImage,
                icon: Icon(Icons.add_circle, size: 40,color: Color(0xffC2E1E7)),
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Expanded(
          child: SizedBox(
            height: 529,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(7),
              itemCount: imagePaths.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0), // 여기서 원하는 반경으로 조절하세요
                    child: Image.file(File(imagePaths[index])),
                  ),
                  onTap: () {
                    showOptionsDialog(context, index);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(),
            ),
          ),
        )
      ],
    );
  }
}