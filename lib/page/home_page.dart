import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic_system/page/change_password_page.dart';
import 'package:hydroponic_system/page/chart_detail_page.dart';
import 'package:hydroponic_system/page/chart_living_page.dart';
import 'package:hydroponic_system/page/login_page.dart';
import 'package:hydroponic_system/widget/sensor_device_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import '../widget/switch_device_card.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref();
  DataSnapshot? snapshot;

  get databaseReference => null;

  bool checkswitch(String status){
    if(status.toLowerCase()=="true" || status.toLowerCase() == "1"){
      return true;
    }
    else {
      return false;
    }
  }
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5,),
                const Text('Live Sensor Devices'),
                const SizedBox(height: 12,),
                Container(
                  decoration: BoxDecoration(
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: StreamBuilder(
                      stream: ref.child("DeviceSensor").onValue,
                      builder: (context, snapshot) {
                        if(snapshot.hasData && !snapshot.hasError &&snapshot.data?.snapshot.value!= null) {
                          if(snapshot.data!.snapshot!.children.length<=0){
                            return const Center(
                              child: Text('No Data'),
                            );
                          }
                          else{
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.snapshot!.children.length,
                              itemBuilder: (context, index){
                                var childLength = snapshot.data!.snapshot!.children!.elementAt(index).children.length;
                                if(childLength<=0){
                                  String key = snapshot.data!.snapshot!.children!.elementAt(index).key.toString();
                                  String val = snapshot.data!.snapshot!.children!.elementAt(index).value.toString();
                                  return Container(
                                    //margin: const EdgeInsets.only(bottom:8),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(10),
                                          highlightColor: MyColor.sky,
                                          hoverColor: MyColor.sky,
                                          onTap: (){
                                            FirebaseDatabase.instance.ref('Switch_Data').update({"${key}": val.toLowerCase()=='true'?'false':'true'});
                                          },
                                          child: SwitchDeviceCard(name:'$key',value: val.toLowerCase()=='true'?true:false),
                                        ),
                                        if(index<snapshot.data!.snapshot!.children.length-1)
                                          const Divider(height: 1,thickness: 1,)
                                      ],
                                    ),
                                    );
                                }
                                else{
                                  var name = snapshot.data!.snapshot.children.elementAt(index).key.toString();
                                  var sensorList = snapshot.data!.snapshot!.children!.elementAt(index).children;

                                  var listUpsort = sensorList;
                                  List<String> keyList = [];
                                  listUpsort.forEach((element){
                                    keyList.add(element.key.toString());
                                  });
                                  keyList.sort();
                                  var keyLast = keyList.last.toString();

                                  String key = listUpsort.firstWhere((element)=>element.key==keyLast).key.toString();
                                  String val = listUpsort.firstWhere((element)=>element.key==keyLast).value.toString();

                                  return Column(
                                      children: [
                                        SensorDeviceCard(name: name,value: val,),
                                        if(index<snapshot.data!.snapshot!.children.length-1 && snapshot.data!.snapshot!.children.length>1)
                                          const Divider(height: 1,thickness: 1,)
                                      ],
                                  );
                                }
                             }
                            );
                          }
                        }
                        else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                ),
                //TODO: Switch Device
                const SizedBox(height: 20,),
                const Text('Switch Devices (ON/OFF)'),
                const SizedBox(height: 12,),
                Container(
                  decoration: BoxDecoration(
                      color: MyColor.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: StreamBuilder(
                      stream: ref.child("Switch_Data").onValue,
                      builder: (context, snapshot) {
                        if(snapshot.hasData && !snapshot.hasError &&snapshot.data?.snapshot.value!= null) {
                          if(snapshot.data!.snapshot!.children.length<=0){
                            return const Center(
                              child: Text('No Data'),
                            );
                          }
                          else{
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.snapshot!.children.length,
                                itemBuilder: (context, index){
                                  var childLength = snapshot.data!.snapshot!.children!.elementAt(index).children.length;
                                  if(childLength<=0){
                                    String key = snapshot.data!.snapshot!.children!.elementAt(index).key.toString();
                                    String val = snapshot.data!.snapshot!.children!.elementAt(index).value.toString();
                                    return Container(
                                      //margin: const EdgeInsets.only(bottom:8),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            borderRadius: BorderRadius.circular(10),
                                            highlightColor: MyColor.sky,
                                            hoverColor: MyColor.sky,
                                            onTap: (){
                                              FirebaseDatabase.instance.ref('Switch_Data').update({"${key}": val.toLowerCase()=='true'?'false':'true'});
                                            },
                                            child: SwitchDeviceCard(name:'$key',value: val.toLowerCase()=='true'?true:false),
                                          ),
                                          if(index<snapshot.data!.snapshot!.children.length-1 && snapshot.data!.snapshot!.children.length>1)
                                            const Divider(height: 1,thickness: 1,)
                                        ],
                                      ),
                                    );
                                  }
                                  else{
                                    var name = snapshot.data!.snapshot.children.elementAt(index).key.toString();
                                    var sensorList = snapshot.data!.snapshot!.children!.elementAt(index).children;

                                    var listUpsort = sensorList;
                                    List<String> keyList = [];
                                    listUpsort.forEach((element){
                                      keyList.add(element.key.toString());
                                    });
                                    keyList.sort();
                                    var keyLast = keyList.last.toString();

                                    String key = listUpsort.firstWhere((element)=>element.key==keyLast).key.toString();
                                    String val = listUpsort.firstWhere((element)=>element.key==keyLast).value.toString();

                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(15)),
                                      child: SensorDeviceCard(name: name,value: val,),
                                    );
                                  }
                                }
                            );
                          }
                        }
                        else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


///Sensor
///Device
class SensorDeviceCard extends StatelessWidget {
  const SensorDeviceCard({
    required this.name,
    required this.value,
    super.key,
  });
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    String _image = '';
    if(name.toLowerCase().contains('temp')){
      _image = 'assets/images/temperature.png';
    }
    else if(name.toLowerCase().contains('ph')){
      _image = 'assets/images/ph.png';
    }
    else if(name.toLowerCase().contains('hum')){
      _image = 'assets/images/drop.png';
    }
    else{
      _image = 'assets/images/temperature.png';
    }
    return Container(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        highlightColor: MyColor.sky,
        onTap: (){
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyColor.white75,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Image(image: AssetImage(_image),width: 35,height: 35,fit: BoxFit.contain,),
              const SizedBox(width: 10,),
              Expanded(child: Text('$name',style: MyTextStyle.normal,)),
              Text('$value',style: MyTextStyle.normal,),
            ],
          ),
        ),
      ),
    );
  }
}
