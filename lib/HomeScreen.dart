import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairapp/caculator/CalculatorControl.dart';
import 'package:hairapp/info/information.dart';
import 'package:hairapp/stylebook/stylebook.dart';
// ignore_for_file: prefer_const_constructors
// const 상수 무시
import 'Home/home.dart';
import 'caculator/caculator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   elevation: 2, //음영 제거
        //   centerTitle: true, //가운데정렬
        //   backgroundColor: Colors.white,
        //   foregroundColor: const Color(0xffBD9DCF),
        //   title: const Text("디자이너 어플"
        //     ,style: TextStyle(
        //       fontSize: 20,
        //       fontStyle: FontStyle.normal,
        //     ),
        //   ),
        // ),
        body: TabBarView(
          children: [
            HomePage(), // '홈' 페이지
            const CalculatorApp(), // '계산기' 페이지
            information(), // '정보 관리' 페이지
            stylebook(), // '스타일북' 페이지
          ],
        ),
        extendBodyBehindAppBar: true,

        bottomNavigationBar: Container(
          color: Colors.black,
          child: Container(
            height: 70,
            padding: EdgeInsets.only(bottom: 10,top: 5),
            child: const TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color(0xffBD9DCF),
              indicatorWeight: 2,
              labelColor: Color(0xffBD9DCF),
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 13,
              ),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  text: '홈',
                ),
                Tab(
                  icon: Icon(Icons.calculate_outlined),
                  text: '계산기',
                ),
                Tab(
                  icon: Icon(
                    Icons.perm_device_information,
                  ),
                  text: '정보 관리',
                ),
                Tab(
                  icon: Icon(
                    Icons.style_outlined,
                  ),
                  text: '스타일북',
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}
