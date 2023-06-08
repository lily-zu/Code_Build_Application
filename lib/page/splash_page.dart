import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../service/splash_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashServices splashServices = SplashServices();
  void getLocal() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      Global.username = prefs.getString('username')??'Unknown';
    });
  }
  @override
  void initState() {
    super.initState();
    getLocal();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('WELCOME' , style: TextStyle(
          fontFamily: MyFont.ptSans,
          fontSize: MyFontSize.large,
          height: 1.5,
          color: MyColor.sky,
        ),),
      ),
    );
  }
}


