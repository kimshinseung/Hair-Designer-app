import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CalculatorControl.dart';
import 'Model.dart';
// const 상수 무시

class CalculatorApp extends StatelessWidget
{
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context)  // This widget is the root of your application.
  {
    return MaterialApp
      (
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: DesignPage(),
    );
  }
}
//-----------------------------------------------------------------------------------------
class DesignPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      body: ChangeNotifierProvider
        (
        create: (BuildContext context) => DisplayNumValue(),
        child :Column
          (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>
          [
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SizedBox(height: 80,),
              ],
            ),
            Flexible
              (
              flex: 1,
              child: Container
                (
                padding: const EdgeInsets.all(20),
                alignment: const Alignment(1.0, 1.0),   // 내부 위젯의 위치를 우측 하단으로 설정
                child: const DisplayValue(),
              ),
            ),
            const Flexible
              (
              flex: 4,
              child: ButtonGroupWidget(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
//-----------------------------------------------------------------------------------------
class DisplayValue extends StatelessWidget
{
  const	DisplayValue({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Text
      (
      context.watch<DisplayNumValue>().displayValue,
      style: TextStyle(color: Colors.black, backgroundColor: Colors.white, fontSize: context.read<DisplayNumValue>().fontSize,),
      textAlign: TextAlign.right,
    ) ;
  }
}
//-----------------------------------------------------------------------------------------
class CalButton extends StatelessWidget
{
  CalButton({super.key, required this.caption, required this.color, required this.buttonKind});
  final String caption ;  // 입력된 버튼의 문자
  final Color color;      // 버튼의 색
  final int buttonKind;   // 입력된 버튼의 기능(0:숫자, 1:연산, 2:기능)

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton
      (
      onPressed: ()
      {
        switch(buttonKind)
        {
          case 0 : calcuControl.numberOnPressed(context, caption); break ;
          case 1 : calcuControl.operatorOnPressed(context, caption); break ;
          case 2 : calcuControl.resultOnPressed(context); break ;
          case 3 : calcuControl.functionOnPressed(context, caption) ; break;
          case 4 : calcuControl.discountRatio(context, caption) ; //할인율
        }
      },
      style: ElevatedButton.styleFrom
        (
        backgroundColor: color,
        fixedSize: Size((MediaQuery.of(context).size.width/4)-30, (MediaQuery.of(context).size.width/4)-20),
        shape: const CircleBorder(),
      ),
      child: Text(caption, style: const TextStyle(fontSize: 13,),),
    );
  }
}
//-----------------------------------------------------------------------------------------
class ButtonGroupWidget extends StatelessWidget
{
  const ButtonGroupWidget({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Table
      (
      children: <TableRow>
      [
        TableRow
          (
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: 'C', color: Color(0xffD7ECF1), buttonKind: 3,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '%', color: Color(0xffD7ECF1), buttonKind: 3,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '⇍', color: Color(0xffD7ECF1), buttonKind: 3,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '÷', color: Color(0xffD7ECF1), buttonKind: 1,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '5%', color: Color(0xff9AACBC), buttonKind: 4,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '30%', color: Color(0xff9AACBC), buttonKind: 4,),),
          ],
        ),
        TableRow
          (
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '7', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '8', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '9', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '×', color: Color(0xffD7ECF1), buttonKind: 1,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '10%', color: Color(0xff9AACBC), buttonKind: 4,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '35%', color: Color(0xff9AACBC), buttonKind: 4,),),
          ],
        ),
        TableRow
          (
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '4', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '5', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '6', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '−', color: Color(0xffD7ECF1),buttonKind: 1,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '15%', color:Color(0xff9AACBC), buttonKind: 4,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '40%', color:Color(0xff9AACBC), buttonKind: 4,),),
          ],
        ),
        TableRow
          (
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '1', color:Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '2', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '3', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+', color: Color(0xffD7ECF1), buttonKind: 1,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '20%', color: Color(0xff9AACBC), buttonKind: 4,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '45%', color: Color(0xff9AACBC), buttonKind: 4,),),
          ],
        ),
        TableRow
          (
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+/-', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Expanded(
              flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(5), child: CalButton(caption: '0', color: Color(0xffD7ECF1), buttonKind: 0,),)),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '.', color: Color(0xffD7ECF1), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '=', color: Color(0xffD7ECF1), buttonKind: 2,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '25%', color: Color(0xff9AACBC), buttonKind: 4,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '50%', color: Color(0xff9AACBC), buttonKind: 4,),),
          ],
        ),
      ],
    );
  }
}