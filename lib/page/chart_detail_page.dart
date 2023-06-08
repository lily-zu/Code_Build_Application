import 'package:flutter/material.dart';

import '../constants.dart';
class ChartDetailPage extends StatefulWidget {
  const ChartDetailPage({Key? key}) : super(key: key);

  @override
  State<ChartDetailPage> createState() => _ChartDetailPageState();
}

class _ChartDetailPageState extends State<ChartDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.darkBlue.withOpacity(0.90),
      appBar: AppBar(
        backgroundColor: MyAppBarStyle.backgroundColor,
        elevation: MyAppBarStyle.elevation,
        centerTitle: MyAppBarStyle.isCenter,
        title: const Text('Chart Detail',style: MyAppBarStyle.textStyle,),
      ),
      body: const Center(child: Text('Not Yet',style: MyTextStyle.normal,),),
    );
  }
}
