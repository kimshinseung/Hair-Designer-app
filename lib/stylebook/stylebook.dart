import 'dart:io';
import 'package:collection/collection.dart'; // collection 패키지를 import 해야 합니다.

import 'package:flutter/material.dart';
import 'package:hairapp/Database/DBHelper.dart';
import 'package:hairapp/stylebook/DetailStyle.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시

class ImageItem {
  final String imagePath;
  final String category;

  ImageItem({required this.imagePath, required this.category});
}

class stylebook extends StatefulWidget {
  const stylebook({super.key});
  @override
  State<stylebook> createState() => _stylebookState();
}

class _stylebookState extends State<stylebook> {

  DBHelper helper = DBHelper();

  List<ImageItem> imageList = [];

  List<ImageItem> firstImagesInCategories = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  //데이터 불러오기
  void loadImages() async {
    var images = await helper.getAllImages();
    var imageItems = images.map((item) => ImageItem(imagePath: item['imagePath'], category: item['category'])).toList();

    // 카테고리별로 첫 번째 이미지만 선택
    var groupedImages = <String, List<ImageItem>>{};
    for (var image in imageItems) {
      groupedImages.putIfAbsent(image.category, () => []).add(image);
    }
    firstImagesInCategories = groupedImages.entries.map((e) => e.value.first).toList();
   // print(firstImagesInCategories);
    setState(() {
      imageList = imageItems;
    });
  }

  // 사진 삭제 함수
  void deleteImage(ImageItem imageItem) async {
    await helper.deleteImage(imageItem.imagePath, imageItem.category);
    setState(() {
      imageList.removeWhere((item) =>
      item.imagePath == imageItem.imagePath &&
          item.category == imageItem.category);

      // 삭제된 이미지를 firstImagesInCategories에서도 제거
      firstImagesInCategories.removeWhere((item) =>
      item.imagePath == imageItem.imagePath &&
          item.category == imageItem.category);
    });
  }

  //데이터 조회
  void showImages() async {
    List<Map<String, dynamic>> images = await helper.getAllImages();
    images.forEach((image) {
      print('Image Path: ${image['imagePath']}, Category: ${image['category']}');
      // 원하는 방식으로 데이터를 출력하거나 활용할 수 있습니다.
    });
  }

  //이미지와 카테고리 추가
  void addImageAndCategory(String imagePath, String category) {
    helper.insertImage(imagePath, category);
    setState(() {
      imageList.add(ImageItem(imagePath: imagePath, category: category));

      // 이미지가 추가된 카테고리가 firstImagesInCategories에 없으면 추가
      var existingCategoryImage = firstImagesInCategories.firstWhereOrNull((item) => item.category == category);
      if (existingCategoryImage == null) {
        firstImagesInCategories.add(ImageItem(imagePath: imagePath, category: category));
      }
    });
  }

  //카테고리에 해당하는 이미지 불러오기
  void getImagesForCategory(String category) async {
    List<Map<String, dynamic>> images = await helper.getImagesByCategory(category);
    List<ImageItem> imageItems = images
        .map((item) => ImageItem(imagePath: item['imagePath'], category: item['category']))
        .toList();
    setState(() {
      imageList = imageItems;
    });
  }

  void addCategory() async {
    String? category = await showDialog(
      context: context,
      builder: (context) {
        TextEditingController categoryController = TextEditingController();
        return AlertDialog(
          title: Text("카테고리 추가"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: InputDecoration(hintText: "이름"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (categoryController.text.isNotEmpty) {
                  // 새 카테고리에 대한 이미지 추가
                  String defaultImagePath = 'assets/images/logo.png'; // 기본 이미지 경로 설정
                  addImageAndCategory(defaultImagePath, categoryController.text);

                  // 이미지 추가 후 해당 카테고리 이미지 로드
                  getImagesForCategory(categoryController.text);

                  Navigator.of(context).pop(categoryController.text);
                }
              },
              child: Text("추가"),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("취소")),
          ],
        );
      },
    );

    if (category != null && category.isNotEmpty) {
      getImagesForCategory(category);
    }

    // 데이터베이스 저장 후 이미지 목록 다시 로드
    loadImages();
  }

  // 사진 삭제 함수
  void onImageClicked(ImageItem imageItem) async {
    String action = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("카테고리 확인"),
          actions: <Widget>[
            TextButton(
              child: Text('보기'),
              onPressed: () {
                Navigator.pop(context, 'view');
              },
            ),
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, 'delete');
              },
            ),
          ],
        );
      },
    );

    if (action == 'delete') {
      deleteImage(imageItem);
    } else if (action == 'view') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailStyle(categoryName: imageItem.category),
        ),
      );
    }
  }

  @override
    Widget build(BuildContext context) {
    List<String> categories = imageList.map((item) => item.category).toSet().toList();
    categories.insert(0, '모두');

    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 50,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset('assets/images/logo4.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,),
                ),
                SizedBox(width: 90,),
                Text("StyleBook",style: TextStyle(
                  fontSize: 24,
                  color: Color(0XffC2E1E7),
                  shadows: [
                    Shadow(
                      offset: Offset(1.0,1.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ]
                ),),
              ],
            ),
            //이미지
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //열의 개수
                  crossAxisSpacing: 4.0, //열사이간격
                  mainAxisSpacing: 4.0//행사이간격
                ),
                itemCount: firstImagesInCategories.length + 1,
                itemBuilder: (context,index) {
                  if (index < firstImagesInCategories.length) {
                    var imageItem = firstImagesInCategories[index];
                    String imagePath = imageItem.imagePath;
                    if (imagePath.startsWith('assets/')) {
                      return GestureDetector(
                        onTap: () => onImageClicked(imageItem),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              imageItem.category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    }else {
                      return GestureDetector(
                        onTap: () => onImageClicked(imageItem),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              imageItem.category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  }else {
                    return InkWell(
                       onTap: addCategory,
                      child: Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.add,size:50),
                      ),
                    );
                  }

                },
              ),
            ),
          ],
        ),
    );
  }
}