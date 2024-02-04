import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hairapp/stylebook/ShowImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hairapp/Database/DBHelper.dart';

import '../Home/ImageViewer.dart';
import '../info/AddInfo.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시

class DetailStyle extends StatefulWidget {
  final String categoryName;

  const DetailStyle({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<DetailStyle> createState() => _DetailStyleState();
}
class _DetailStyleState extends State<DetailStyle> {
  DBHelper helper = DBHelper();
  late List<Map<String, dynamic>> images;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    images = await helper.getImagesByCategory(widget.categoryName);
    setState(() {});
  }

  //앨범에서 이미지 가져오기
  Future<void> _getImageFromGallery() async {
    // 새로운 메소드를 사용하여 이미지 선택
    final File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      File file = File(imageFile.path);
      await helper.insertImage(file.path, widget.categoryName);
      await loadImages();
    }
  }
  Future<void> showDeleteDialog(String imagePath) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("이미지를 삭제하시겠습니까?",
          style: TextStyle(
            fontSize: 27,
          ),),
          actions: [
            TextButton(
              onPressed: () async {
                await helper.deleteImage(imagePath, widget.categoryName);
                await loadImages();
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text("삭제",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text("취소",style: TextStyle(
                fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(widget.categoryName,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0,1.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.3),
                      )
                    ]
                ),
                ),
              ),
            ],
          ),
          Expanded(
              child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: images.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        _getImageFromGallery();
                      },
                      child: Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.add, size: 50),
                      ),
                    );
                  } else {
                    var imageIndex = index - 1;
                    String imagePath = images[imageIndex]['imagePath'];
                    if (imagePath.startsWith('assets/')) {
                      return GestureDetector(
                        onLongPress: (){
                          showDeleteDialog(imagePath);
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowImage(imageProvider: AssetImage(imagePath)),
                            ),
                          );
                        },
                        child: Image.asset(imagePath, fit: BoxFit.cover),
                      );
                    } else {
                      return GestureDetector(
                        onLongPress: (){
                          showDeleteDialog(imagePath);
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowImage(imageProvider: FileImage(File(imagePath))),
                            ),
                          );
                        },
                        child: Image.file(File(imagePath), fit: BoxFit.cover),
                      );
                    }
                  }
                },
              ),
          ),
        ],
      )
    );
  }
}