import 'dart:io';
import 'package:flutter/material.dart';
//-----------------------------------------------------------------------------------------
class DisplayNumValue with ChangeNotifier
{
  String _displayValue = '0' ;
  double _fontSize = 80 ;

  String get displayValue => _displayValue;
  double get fontSize => _fontSize;

  void Display(String value, double fontSize)
  {
    _displayValue = value ;
    _fontSize = fontSize ;

    notifyListeners();  //<-- 변경 내용을 전파(알림)
  }
}