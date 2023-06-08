import 'package:flutter/material.dart';

import '../constants.dart';
class SwitchDeviceCard extends StatelessWidget {
  const SwitchDeviceCard({
    required this.name,
    required this.value,
    super.key,
  });
  final String name;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15,top: 15,right: 15,bottom: 10),
      color: MyColor.white,
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          const Image(image: AssetImage('assets/images/button.png'),width: 35,height: 35,fit: BoxFit.contain,),
          const SizedBox(width: 10,),
          Expanded(child: Text('$name',style: MyTextStyle.normal,)),
          Text(value?'ON':'OFF',style: MyTextStyle.normalWithColor(value==true?MyColor.green:MyColor.black),),
        ],
      )
    );
  }
}
