import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic_system/page/home_page.dart';
import 'package:hydroponic_system/page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../page/main_page.dart';
class SplashServices{

  void isLogin(BuildContext context) {

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      Timer(const Duration(seconds: 2),
              ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()))
      );
    }else {
      Timer(const Duration(seconds: 2),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInPage()))
      );
    }

  }
}
