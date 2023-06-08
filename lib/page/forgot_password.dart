import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class ForgotPasswordSreen extends StatefulWidget {
  const ForgotPasswordSreen({super.key});

  @override
  State<ForgotPasswordSreen> createState() => _ForgotPasswordSreenState();
}

class _ForgotPasswordSreenState extends State<ForgotPasswordSreen> {

  final emailController =TextEditingController();
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyAppBarStyle.backgroundColor,
        elevation: MyAppBarStyle.elevation,
        centerTitle: MyAppBarStyle.isCenter,
        title: const Text('Forgot Password',style: MyAppBarStyle.textStyle,),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Text('Email',style: MyTextStyle.normal,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
              decoration: BoxDecoration(
                  color: MyColor.white45,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                controller: emailController,
                obscureText: false,
                style: MyTextStyle.normal,
                decoration: const InputDecoration(
                    border: InputBorder.none
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter your email';
                  }
                  return null ;
                },
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                if(_formKey.currentState!.validate()){
                  auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                    //   Utils().toastMassage('we have send you email to rocover password please check email');
                    // }).onError((error, stackTrace){
                    //   Utils().toastMassage(error.toString());
                  });
                }//Me
                //await onSavePress();
              },
              child: const Text('Forgot',style: TextStyle(fontSize: 16),),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(MyColor.white),
                backgroundColor: MaterialStateProperty.all(MyColor.sky),
                fixedSize: MaterialStateProperty.all( const Size(400, 55)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}