import 'package:flutter/material.dart';
import 'package:hairapp/caculator/ButtonGroupWidget.dart';

import 'caculator/displayText.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var displayNumber = '0';
    var makeNumber = '' ;
    var selectedOperator = '−';
    var displayFontSize = 80.0 ;
    var pointExist = false ;

    var firstNumber = 0.0 ;
    var secondNumber = 0.0 ;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, //음영 제거
        centerTitle: true, //가운데정렬
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text("디자이너 전용 계산기"
          ,style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>
        [
          Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment(1.0,1.0),// 내부 위젯의 위치를 우측 하단으로 설정
            color: Colors.black,
            height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 0.30,   // 화면의 30%를 차지하도록 설정
            child: displayText(caption: '$displayNumber', fontsize: displayFontSize,),
          ),
          ButtonGroupWidget(),
        ],
      ),
    );
  }

}
