import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시
class stylebook extends StatelessWidget {
  const stylebook({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
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
              ],
            ),
          ],

        )
    );
  }
}