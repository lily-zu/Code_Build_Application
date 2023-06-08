
//TODO: App Information
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic_system/page/chart.dart';
import 'package:hydroponic_system/page/chart_living_page.dart';
import 'package:hydroponic_system/page/home_page.dart';
import 'package:hydroponic_system/page/profile_page.dart';

//TODO: IconData
class MyIconData{
  static const menu = FluentIcons.data_bar_horizontal_24_regular;
  static const home = FluentIcons.home_20_regular;
  static const home_fill = FluentIcons.home_20_filled;
  static const search = FluentIcons.search_20_regular;
  static const search_fill = FluentIcons.search_20_filled;

  static const chart = FluentIcons.arrow_trending_lines_24_regular;
  static const password = FluentIcons.lock_closed_24_regular;
  static const signout = FluentIcons.sign_out_24_regular;

  static const saveTage_fill = FluentIcons.star_20_filled;
  static const savedTage = FluentIcons.star_20_filled;
  static const profile = FluentIcons.person_20_regular;
  static const profile_fill = FluentIcons.person_20_filled;
  static const folder = FluentIcons.folder_20_regular;
  static const folder_fill = FluentIcons.folder_20_regular;
  static const dot = FluentIcons.circle_20_regular;
  static const dot_fill = FluentIcons.circle_20_filled;
  static const delete = FluentIcons.delete_24_regular;
  static const delete_fill = FluentIcons.delete_24_filled;
  static const next = FluentIcons.chevron_right_12_regular;
  static const back = FluentIcons.chevron_left_12_regular;
}

//TODO: Color
class MyColor{
  static const transparent = Colors.transparent;
  static const white = Color(0xfffdfdfe);
  static const white75 = Color(0xfffdfdfe);
  static const white45 = Color(0xffeef1f7);
  static const sky = Color(0xff035a8d);
  static const blue = Color(0xff142a38);
  static const bg = Color(0xff0b4470);
  static const darkBlue = Color(0xff0a1c29);
  static const gray = Color(0xffcacacb);
  static const grey = Color(0xff545455);
  static const green = Color(0xff10a60e);
  static const black = Color(0xff111112);
}
//TODO : App Bar
class MyAppBarStyle {
  static const backgroundColor = MyColor.sky;
  static const elevation = 0.4;
  static const isCenter = true;
  static const textStyle = TextStyle(
      fontSize: 16.0,
      fontFamily: MyFont.ptSans,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: MyColor.white
  );
}

//TODO: GLobal
class Global {
  static String? username = '';
}
//TODO: Font Family
class MyFont{
  static const ptSans = 'PT Sans';
}

//TODO: fontSize
class MyFontSize{
  static const normal = 16.0;
  static const small = 14.0;
  static const tiny = 11.0;
  static const big = 18.0;
  static const large = 30.0;
}

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({Key? key ,
    required this.title,
    required this.onTap,
    this.loading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :
        Text(title, style: TextStyle(color: Colors.white),),),
      ),
    );

  }
}
//TODO: Page/Screens
List<Widget> pageList = const[
  HomePage(),
  ChartLivingPage(),
  //ChartPage(),
  ProfilePage(),
];
List<String> titleList = const['HOME','CHART','SETTING'];

//TODO: Bottom Navigation Bar
class MyBottomAppBarStyle{
  static const Color selectedColor = MyColor.sky;
  static const Color backgroundColor = MyColor.white75;
  static const Color unselectedColor = MyColor.grey;
  static const double height = 60.0;
  static const double iconSize = 25.0;
  static const String fontFamily = MyFont.ptSans;
  static const double fontSize = 12.0;
}
//TODO: TextStyle
class MyTextStyle{

  //status
  static const statusClosed = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.green,
  );
  static const statusPending = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.green,
  );
  static const statusAll = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.black,
  );
  //text
  static const normal = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.black,
  );
  static normalWithColor(Color color)=>TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: color,
  );
  static const title = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.white,
  );
  static const header = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.white,
  );
  static const content = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.grey,
  );
  static const link = TextStyle(
    fontFamily: MyFont.ptSans,
    fontSize: MyFontSize.normal,
    height: 1.5,
    color: MyColor.sky,
  );
}

