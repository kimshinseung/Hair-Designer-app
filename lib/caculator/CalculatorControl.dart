import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Model.dart';

var calcuControl = new CalculatorControl() ;

class CalculatorControl
{
  var makeNumber = '' ;
  var selectedOperator = '+';
  var pointExist = false ;

  dynamic firstNumber = 0 ;
  dynamic secondNumber = 0 ;

  void operatorOnPressed(BuildContext context, String st)
  {
    resultOnPressed(context) ;

    selectedOperator = st ;
    firstNumber = double.parse(context.read<DisplayNumValue>().displayValue) ;
  }
  void discountRatio(BuildContext context, String st) {
    var display = '0' ;
    firstNumber = double.parse(context.read<DisplayNumValue>().displayValue) ;

    switch(st) {
      case '5%' : firstNumber = firstNumber * 0.95; break;
      case '10%' : firstNumber = firstNumber * 0.9; break;
      case '15%' : firstNumber = firstNumber * 0.85; break;
      case '20%' : firstNumber = firstNumber * 0.8; break;
      case '25%' : firstNumber = firstNumber * 0.75; break;
      case '30%' : firstNumber = firstNumber * 0.7; break;
      case '35%' : firstNumber = firstNumber * 0.65; break;
      case '40%' : firstNumber = firstNumber * 0.6; break;
      case '45%' : firstNumber = firstNumber * 0.55; break;
      case '50%' : firstNumber = firstNumber * 0.5; break;
    }
    display = firstNumber.toString();
    if(display.length >= 3 && display.startsWith('.0', display.length-2))
    {
      display = display.substring(0, display.length-2) ;  // 정수일 경우 소수점 이하 지워라...
    }
    _display(context, display);
  }

  //-----------------------------------------------------------------------------------------
  void resultOnPressed(BuildContext context)
  {
    var display = '0' ;
    secondNumber = double.parse(context.read<DisplayNumValue>().displayValue) ;
    makeNumber = '';

    switch(selectedOperator)
    {
      case '+' : firstNumber = firstNumber + secondNumber ;	break ;
      case '−' : firstNumber = firstNumber - secondNumber ;	break ;
      case '×' : firstNumber = firstNumber * secondNumber ;	break ;
      case '÷' : firstNumber = firstNumber / secondNumber ;	break ;
    }

    display = firstNumber.toString();
    firstNumber = 0 ;
    selectedOperator = '+';
    pointExist = false ;

    if(display.length >= 3 && display.startsWith('.0', display.length-2))
    {
      display = display.substring(0, display.length-2) ;  // 정수일 경우 소수점 이하 지워라...
    }

    _display(context, display) ;
  }
  //-----------------------------------------------------------------------------------------
  void functionOnPressed(BuildContext context, String st)
  {
    var display = '0' ;

    if(st == 'C')		// clear input
        {
      selectedOperator = '+';
      makeNumber = '';
      firstNumber = 0 ;
      secondNumber = 0 ;
    }
    else if(st == '%')
    {
      var imsi = double.parse(context.read<DisplayNumValue>().displayValue) / 100 ;

      if(selectedOperator == '+' || selectedOperator == '-' )
      {
        display = (imsi * firstNumber).toString();
      }
      else
      {
        display = imsi.toString();
      }
    }
    else
    {
      var imsiString = context.read<DisplayNumValue>().displayValue ;
      makeNumber = '';

      if(imsiString.length > 1)
      {
        display = imsiString.substring(0, imsiString.length-1) ;
        makeNumber = display;
      }
    }

    _display(context, display) ;
  }
  //-----------------------------------------------------------------------------------------
  void numberOnPressed(BuildContext context, String st)  		// 숫자키 입력 이벤트 함수
  {
    bool inputAdd = true ;

    if(st == '.') // 소숫점이 눌려졌을 경우
        {
      if(makeNumber.isEmpty == true)
      {
        makeNumber += '0.';
        inputAdd = false ;
      }
      else
      {
        if(pointExist == true) inputAdd = false ; // 소숫점이 없을 경우만 추가
      }

      pointExist = true ;
    }
    else if(st == '0' && makeNumber.isEmpty == true)  inputAdd = false;

    if(inputAdd == true)
    {
      makeNumber += st ;
    }

    _display(context, makeNumber) ;
  }
  //-----------------------------------------------------------------------------------------
  void _display(BuildContext context, String Number)  // private member function
  {
    var fontSizes = 80.0 ;
    if(Number.length >= 8) fontSizes = 50 ;  // 글자 크기를 선택

    context.read<DisplayNumValue>().Display(Number, fontSizes) ;
  }
//-----------------------------------------------------------------------------------------
}