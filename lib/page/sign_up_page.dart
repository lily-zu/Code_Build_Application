import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic_system/page/login_page.dart';

import '../constants.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  //controller
  final  _usernameController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // TextEditingController _usernameController = TextEditingController();
  // TextEditingController _newPasswordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

  }

  void signUp(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: _usernameController.text.toString(),
        password: _newPasswordController.text.toString()).then((value){
      setState(() {
        loading = false;
      });
       Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LogInPage()
        ),
      );
      
    }).onError((error, stackTrace){
      // Utils().toastMassage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  Future<void> onSavePress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SearchResultPage(
      //       provinceCode: _selectedProvince?.provinceCode ?? 0,
      //       communeCode: checkCommune,
      //       caseFileCode: _caseFileCode,
      //     ),
      //   ),
      // );
    } else {
      //print('Not valid!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      appBar: AppBar(
        backgroundColor: MyAppBarStyle.backgroundColor,
        elevation: MyAppBarStyle.elevation,
        centerTitle: MyAppBarStyle.isCenter,
        title: const Text('Sign Up',style: MyAppBarStyle.textStyle,),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
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
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter email';
                  }
                  return null ;
                },
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20,),
            const Text('New Password',style: MyTextStyle.normal),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
              decoration: BoxDecoration(
                  color: MyColor.white45,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                style: MyTextStyle.normal,
                decoration: const InputDecoration(
                    border: InputBorder.none
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter password';
                  }
                  return null ;
                },
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Confirm Password',style: MyTextStyle.normal,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
              decoration: BoxDecoration(
                  color: MyColor.white45,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                style: MyTextStyle.normal,
                decoration: const InputDecoration(
                    border: InputBorder.none
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter password confirm';
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
                  signUp();
                }//Me
                //await onSavePress();
              },
              child: const Text('Save',style: TextStyle(fontSize: 16),),
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
