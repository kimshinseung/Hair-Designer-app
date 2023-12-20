import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class displayText extends StatelessWidget
{
  displayText({super.key, required this.caption, required this.fontsize});
  final String caption ;
  final double fontsize ;

  @override
  Widget build(BuildContext context)
  {
    return Text
      (
      '$caption',
      style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontSize: fontsize,),
      textAlign: TextAlign.right,
    ) ;
  }
}