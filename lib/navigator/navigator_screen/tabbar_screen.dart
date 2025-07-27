import 'package:dna/navigator/navigator_tabbar/profile_tabbar.dart';
import 'package:dna/navigator/navigator_tabbar/progess_photo_tabbar.dart';
import 'package:dna/navigator/navigator_tabbar/schedule_tabbar.dart';
import 'package:dna/navigator/navigator_tabbar/home_tabbar.dart';
import 'package:flutter/material.dart';

// Màn hình 7

class TabbarScreen extends StatefulWidget
{
  @override
  State<TabbarScreen> createState() => _StateTabbarScreen();
}

class _StateTabbarScreen extends  State<TabbarScreen>
{
  int _selectedIndex = 0;

  final List<Widget> _screen = [  
    HomeTabbar(),
    ScheduleTabbar(),
    ProgessPhotoTabbar(),
    ProfileTabbar()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override

  Widget build (BuildContext context)
  {
    return WillPopScope(
      onWillPop: () async {
        return true;
      }, 
      child: Scaffold(
        body: _screen[_selectedIndex],
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          shape: CircleBorder(),
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.search, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              //Left Icon
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                       _onItemTapped(0);
                      }, 
                      icon: Icon(
                        Icons.home,
                        color: _selectedIndex == 0 ? Colors.pinkAccent : Colors.grey
                      )
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: (){
                       _onItemTapped(1);
                      }, 
                      icon: Icon(
                        Icons.message,
                        color: _selectedIndex == 1 ? Colors.pinkAccent : Colors.grey
                      )
                    ),
                  ],
                ),
                // Right Icon
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                       _onItemTapped(2);
                      }, 
                      icon: Icon(
                        Icons.camera,
                        color: _selectedIndex == 2 ? Colors.pinkAccent : Colors.grey
                      )
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: (){
                       _onItemTapped(3);
                      }, 
                      icon: Icon(
                        Icons.person,
                        color: _selectedIndex == 3 ? Colors.pinkAccent : Colors.grey
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        )  
      )   
    );
  }
}



