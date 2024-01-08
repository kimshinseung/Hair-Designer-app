import 'package:flutter/material.dart';
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

  List<ImageItem> imageList = [
    ImageItem(imagePath: 'assets/images/logo.png', category: '남자 커트'),
    ImageItem(imagePath: 'assets/images/logo.png', category: '여자 커트'),
  ];
  
  //카테고리 추가
  void addCategory() async {
    String category = await showDialog(context: context,
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
            //이미지 추가
          ],
        ),
        actions: [
          TextButton(onPressed: () =>Navigator.of(context).pop(), child: Text("취소")),
          TextButton(onPressed: () => Navigator.of(context).pop(categoryController.text), child: Text("추가")),
        ],
      );
    },
    );

    if(category != null && category.isNotEmpty) {
      setState(() {
        imageList.add(ImageItem(imagePath: 'assets/images/logo.png', category: category));
      });
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
                itemCount: imageList.length + 1,
                itemBuilder: (context,index) {
                  if(index<imageList.length){
                    return Column(
                      children: <Widget> [
                        Expanded(child: Image.asset(
                          imageList[index].imagePath,
                          fit: BoxFit.cover,
                        ),
                        ),
                        Text(
                          imageList[index].category,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    );
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