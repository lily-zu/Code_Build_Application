import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydroponic_system/page/forgot_password.dart';
import 'package:hydroponic_system/page/home_page.dart';
import 'package:hydroponic_system/page/main_page.dart';
import 'package:hydroponic_system/page/sign_up_page.dart';
import 'package:hydroponic_system/page/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  //controller
  final  _usernameController = TextEditingController();
  final  _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

  }
  String username='';
  void login() {
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text.toString()).then((value) async{
      // Utils().toastMassage(value.user!.email.toString());
      username = _usernameController.text;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString('username', username);
        loading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      // Utils().toastMassage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }
  Future<void> savedLocal() async{

  }
  Future<void> onSavePress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    } else {
      //print('Not valid!');
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child:  Scaffold(
      backgroundColor: MyColor.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Lottie.asset('assets/hello.json',width: 230,height: 230,fit: BoxFit.contain),
                  const SizedBox(height: 5,),
                    const Text('WELCOME',style: MyTextStyle.title,),
                    Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Username',style: MyTextStyle.normal,),
                          const SizedBox(height: 10,),
                          Container(
                            padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
                            decoration: BoxDecoration(
                                color: MyColor.white45,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: TextFormField(
                              controller: _usernameController,
                              style: MyTextStyle.normal,
                              decoration: const InputDecoration(
                                  border: InputBorder.none
                              ),
                              //Me
                              validator: (value) {
                                if(value!.isEmpty){
                                  return 'Enter email';
                          }
                                return null ;
                          },

                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const Text('Password',style: MyTextStyle.normal,),
                          const SizedBox(height: 10,),
                          Container(
                            padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
                            decoration: BoxDecoration(
                                color: MyColor.white45,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,//me
                              style: MyTextStyle.normal,
                              decoration: const InputDecoration(
                                  border: InputBorder.none
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Enter password';
                                }
                                return null ;
                              },//me
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          // //me
                          // const SizedBox(height: 50,),
                          // RoundButton(
                          //   title: 'Login',
                          //   loading: loading,
                          //   onTap: (){
                          //     if(_formKey.currentState!.validate()){
                          //       login();
                          //     }
                          //   },
                          // ),

                          const SizedBox(height: 10,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: const[
                          //      Text('Forgot password?',style: MyTextStyle.content,),
                          //   ],
                          // ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder:(context) => const ForgotPasswordSreen())
                              );
                          
                            },
                                child: const Text('Forgot Password?', style: MyTextStyle.content,)),
                          ),
                          
                          
                          const SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              //await onSavePress();
                              if(_formKey.currentState!.validate()){
                                login();
                              }
                            },
                            child: const Text('Login',style: TextStyle(fontSize: 16),),
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
                  ),
                  const SizedBox(height: 35,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text('Don\'t have an account?  ',style: MyTextStyle.content,),
                      GestureDetector(
                        child: const Text('Sign Up',style: MyTextStyle.link,),
                        onTap: (){
                          if(_formKey.currentState!.validate()){
                            login();
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },

                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ), 
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
    );
  }
}
