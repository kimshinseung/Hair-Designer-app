
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시

String searchText = '';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> images = [];


  void addImage() {
    setState(() {
      //images.clear();
      images.add(Image.asset("assets/images/logo.png")); //여기서 사진 추가하면 됨
      print(images.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset('assets/images/logo.png',
                width: 80,
                height: 80,
                fit: BoxFit.contain,),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: IconButton(onPressed: addImage, icon: Icon(Icons.add_box_rounded,size: 40,)),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal:100,vertical: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: '이름을 입력해주세요.',
                border: OutlineInputBorder(),
              ),

            ),
          ),
          Center(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ListTile(
                    title: Text("a"),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )
        ],
      ),
    );
  }
}