import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairapp/info/AddInfo.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시
class information extends StatefulWidget {
  @override
  State<information> createState() => _informationState();
}

class _informationState extends State<information> {
  void addInfo() {
    setState(() {
    });
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
                child: Image.asset('assets/images/logo.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: IconButton(onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddInfo()),);
                }, icon: Icon(Icons.add_box_rounded,size: 40,)),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title:Text("$index"),
                  // onTap: (){
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => ImageViewer(path: images[index],)),
                  //   );
                  // },
                );
              }, separatorBuilder: (BuildContext context, int index) => Divider(),
            ),
          )
        ],
      )
    );
  }
}
