import 'dart:io';

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

    setState(() {
      imageList = imageItems;
    });
  }

  // 사진 삭제 함수
  void deleteImage(ImageItem imageItem) async {
    await helper.deleteImage(imageItem.imagePath, imageItem.category);
    setState(() {
      imageList.removeWhere((item) => item.imagePath == imageItem.imagePath && item.category == imageItem.category);
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

  //카테고리 추가
  void addCategory() async {
    String category = await showDialog(
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
              // 이미지 추가
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  addImageAndCategory('assets/images/logo.png', categoryController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text("추가"),
            ),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("취소")),
          ],
        );
      },
    );

    if(category != null && category.isNotEmpty) {
      getImagesForCategory(category);
    }
    //데이터베이스 저장후 이미지 목록 다시 로드
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
        body: Column(
          children: [
            const SizedBox(height: 50,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset('assets/images/logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,),
                ),
                SizedBox(width: 90,),
                Text("스타일북",style: TextStyle(
                  fontSize: 24,
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
                    var imageIndex = index;
                    String imagePath = imageList[imageIndex].imagePath;
                    if (imagePath.startsWith('assets/')) {
                      return GestureDetector(
                        onTap: () => onImageClicked(imageList[imageIndex]),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              imageList[imageIndex].category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => onImageClicked(imageList[imageIndex]),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              imageList[imageIndex].category,
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