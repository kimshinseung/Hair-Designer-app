import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalButton extends StatelessWidget
{
  CalButton({super.key, required this.caption, required this.color, required this.buttonKind});
  final String caption ;  // 버튼에 들어갈 문자
  final Color color;      // 버튼의 색
  final int buttonKind;   // 입력된 버튼의 기능(0:숫자, 1:연산, 2:기능)

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton
      (
      onPressed: () {},  // 버튼입력 이벤트 처리 부분(나중에 코드 추가)
      style: ElevatedButton.styleFrom
        (
        backgroundColor: color,
        fixedSize: Size((MediaQuery.of(context).size.width/4)-30, (MediaQuery.of(context).size.width/4)-20),
        shape: const CircleBorder(),   // 버튼 모양은 원형
      ),
      child: Text('$caption', style: TextStyle(fontSize: 40,),),  // 버튼의 들어가는 글자 모양
    );
  }
}