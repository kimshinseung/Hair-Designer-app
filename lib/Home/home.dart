import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import 'ImageViewer.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시

String searchText = '';
List<Widget> images = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(image != null) {
      File imageFile = File(image.path);
      addImage(imageFile);
    }
  }

  void addImage(File image) {

    Widget imagewidget = Image.file(image);
    setState(() {
      images.insert(0,imagewidget); //여기서 사진 추가하면 됨
    });
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
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: '이름을 입력해주세요',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: IconButton(onPressed: pickImage, icon: Icon(Icons.add_box_rounded,size: 40,)),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal:100,vertical: 0),
          child: TextField(
            decoration: InputDecoration(
              hintText: '이름을 입력해주세요.',
              border: OutlineInputBorder(),
            ),

          ),
        ),
        Container(
          height: 549,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title:images[index],
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageViewer(path: images[index],)),
                  );
                },
              );
            }, separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        )
      ],
    );
  }
}