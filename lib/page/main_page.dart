import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widget/my_bottom_app_bar.dart';
import 'chart_living_page.dart';
import 'login_page.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref();
  void getLocalData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Global.username = prefs.getString('username')??'';
    });
  }
  @override
  int? _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white45,
      appBar: AppBar(
        backgroundColor: MyAppBarStyle.backgroundColor,
        elevation: MyAppBarStyle.elevation,
        centerTitle: MyAppBarStyle.isCenter,
        title: Text('${titleList[_selectedIndex!]}',style: MyAppBarStyle.textStyle,),
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: const Icon(MyIconData.menu,size: 30,),
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //     splashColor: MyColor.transparent,
        //     highlightColor: MyColor.transparent,
        //   ),
        // ),
      ),
      body: pageList[_selectedIndex!],
      bottomNavigationBar: MyBottomAppBar(
        color: MyBottomAppBarStyle.unselectedColor,
        backgroundColor: MyBottomAppBarStyle.backgroundColor,
        selectedColor: MyBottomAppBarStyle.selectedColor,
        iconSize: MyBottomAppBarStyle.iconSize,
        height: MyBottomAppBarStyle.height,
        fontFamily: MyBottomAppBarStyle.fontFamily,
        fontSize: MyBottomAppBarStyle.fontSize,
        onTabSelected: (value){
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          MyBottomAppBarItem(iconData: _selectedIndex==0?MyIconData.home_fill:MyIconData.home, text: 'HOME'),
          MyBottomAppBarItem(iconData: _selectedIndex==1?MyIconData.chart:MyIconData.chart, text: 'CHART'),
          MyBottomAppBarItem(iconData: _selectedIndex==2?MyIconData.profile_fill:MyIconData.profile, text: 'SETTING'),
        ],
      ),
    );
  }
}
