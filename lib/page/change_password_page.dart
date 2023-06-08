import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //controller
  // TextEditingController _currentPasswordController = TextEditingController();
  // TextEditingController _newPasswordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();
  final  _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

  }
  void change(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: _currentPasswordController.text.toString(),
        password: _newPasswordController.text.toString()).then((value){
      setState(() {
        loading = false;
      });
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
      backgroundColor: MyColor.darkBlue.withOpacity(0.90),
      appBar: AppBar(
        backgroundColor: MyAppBarStyle.backgroundColor,
        elevation: MyAppBarStyle.elevation,
        centerTitle: MyAppBarStyle.isCenter,
        title: const Text('Change Password',style: MyAppBarStyle.textStyle,),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Text('Current Password',style: MyAppBarStyle.textStyle,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
              decoration: BoxDecoration(
                color: MyColor.blue,
                borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                controller: _currentPasswordController,
                style: MyTextStyle.normal,
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20,),
            const Text('New Password',style: MyAppBarStyle.textStyle,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
              decoration: BoxDecoration(
                  color: MyColor.blue,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                controller: _newPasswordController,
                style: MyTextStyle.normal,
                decoration: const InputDecoration(
                    border: InputBorder.none
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Confirm Password',style: MyAppBarStyle.textStyle,),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(left: 12,top: 4,bottom: 4,right: 12),
              decoration: BoxDecoration(
                  color: MyColor.blue,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                controller: _confirmPasswordController,
                style: MyTextStyle.normal,
                decoration: const InputDecoration(
                    border: InputBorder.none
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                //await onSavePress();
              },
              child: const Text('Save Change',style: TextStyle(fontSize: 16),),
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
