import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CalButton.dart';

class ButtonGroupWidget extends StatelessWidget
{
  const ButtonGroupWidget({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Table
      (
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>
      {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>
      [
        TableRow
          (
          decoration: const BoxDecoration(color: Colors.black,),
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: 'C', color: Colors.grey, buttonKind: 2,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+/-', color: Colors.grey, buttonKind: 1,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '%', color: Colors.grey, buttonKind: 1,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '÷', color: Colors.orange, buttonKind: 1,),),
          ],
        ),
        TableRow
          (
          decoration: const BoxDecoration(color: Colors.black,),
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '7', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '8', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '9', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '×', color: Colors.orange, buttonKind: 1,),),
          ],
        ),
        TableRow
          (
          decoration: const BoxDecoration(color: Colors.black,),
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '4', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '5', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '6', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '−', color: Colors.orange,buttonKind: 1,),),
          ],
        ),
        TableRow
          (
          decoration: const BoxDecoration(color: Colors.black,),
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '1', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '2', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '3', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '+', color: Colors.orange, buttonKind: 1,),),
          ],
        ),
        TableRow
          (
          decoration: const BoxDecoration(color: Colors.black,),
          children: <Widget>
          [
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '0', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '2', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 1,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '.', color: Color.fromARGB(255, 61, 61, 61), buttonKind: 0,),),
            Padding(padding: EdgeInsets.all(5), child: CalButton(caption: '=', color: Colors.orange, buttonKind: 2,),),
          ],
        ),
      ],
    );
  }
}