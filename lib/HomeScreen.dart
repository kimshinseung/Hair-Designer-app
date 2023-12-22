import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        body: const TabBarView(
          children: [
            Center(
              child: Text('home'),
            ),
            Center(
              child: Text('music'),
            ),
            Center(
              child: Text('apps'),
            ),
            Center(
              child: Text('settings'),
            ),
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
              indicatorColor: Colors.red,
              indicatorWeight: 2,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: 13,
              ),
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.music_note),
                  text: 'Music',
                ),
                Tab(
                  icon: Icon(
                    Icons.apps,
                  ),
                  text: 'Apps',
                ),
                Tab(
                  icon: Icon(
                    Icons.settings,
                  ),
                  text: 'Settings',
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}
