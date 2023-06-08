import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic_system/page/login_page.dart';

import '../constants.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: MyColor.gray.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Icon(MyIconData.profile_fill,size: 35,color: MyColor.grey,),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text: TextSpan(
                              text: 'USERNAME',
                              style: MyTextStyle.normalWithColor(Colors.blueGrey),
                              children:const  <TextSpan>[
                                TextSpan(
                                    text: '',
                                    style: MyTextStyle.normal
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text: TextSpan(
                              text: Global.username!,
                              style: MyTextStyle.normal,
                              children: const <TextSpan>[
                                TextSpan(
                                    text: '',
                                    style: MyTextStyle.normal
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50,),
              RichText(
                textAlign: TextAlign.center,
                softWrap: true,
                text: TextSpan(
                  text: 'Version: ',
                  style: MyTextStyle.normalWithColor(Colors.blueGrey),
                  children: const <TextSpan>[
                    TextSpan(
                        text: '1.0.0',
                        style: MyTextStyle.normal
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                onPressed: (){
                  auth.signOut().then((value){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const LogInPage()));
                  }).onError((error, stackTrace){

                    final snackBar = SnackBar(content: Text(error.toString(),));
                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //Utils().toastMassage(error.toString());
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogInPage(),
                    ),
                  );
                },
                child: const Text('Log Out',
                  style: TextStyle(
                    color: MyColor.green,
                    fontFamily: MyFont.ptSans,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        color: MyColor.green
                    ),
                    backgroundColor: MyColor.white,
                    foregroundColor: MyColor.green,
                    fixedSize: const Size(400, 45),
                    elevation: 0,
                    side: const BorderSide(
                        color: MyColor.gray
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    shadowColor: MyColor.white
                ),
              ),


              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
