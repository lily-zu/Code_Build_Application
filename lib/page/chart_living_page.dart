import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants.dart';
import '../widget/sensor_device_card.dart';
class ChartLivingPage extends StatefulWidget {
  const ChartLivingPage({Key? key}) : super(key: key);

  @override
  State<ChartLivingPage> createState() => _ChartLivingPageState();
}

class _ChartLivingPageState extends State<ChartLivingPage> {

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

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 0.0;
    const textStyle = MyTextStyle.title;
    return SafeArea(
      child:StreamBuilder(
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
                    padding: const EdgeInsets.all(12),
                    itemCount: snapshot.data!.snapshot!.children.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var childLength = snapshot.data!.snapshot!.children!.elementAt(index).children.length;
                      if(childLength>0){
                        var name = snapshot.data!.snapshot.children.elementAt(index).key.toString();
                        var sensorList = snapshot.data!.snapshot!.children!.elementAt(index).children;
                        int limit = 100;
                        var listUnsort = sensorList;


                        List<String> keyList = [];
                        listUnsort.forEach((element){
                          keyList.add(element.key.toString());
                        });
                        keyList.sort();
                        var limitKeyList =[];
                        //print('keylist:${keyList.length}');
                        if(keyList.length>=limit){
                          for(int i=keyList.length-limit;i<keyList.length;i++){
                            limitKeyList.add(keyList.elementAt(i));
                            //print(keyList.elementAt(i));
                          }
                        }
                        var keyLast = limitKeyList.last.toString();
                        String key = listUnsort.firstWhere((element)=>element.key==keyLast).key.toString();
                        String val = listUnsort.firstWhere((element)=>element.key==keyLast).value.toString();
                        List<ScatterSpot> chart = [];
                        double i=0;
                        limitKeyList.forEach((e) {
                          String valueStr = listUnsort.firstWhere((element)=>element.key==e).value.toString();
                          if(valueStr.contains('C'))valueStr = valueStr.replaceAll('C', '').toString();
                          if(valueStr.contains('c'))valueStr = valueStr.replaceAll('c', '').toString();
                          if(valueStr.contains('%'))valueStr = valueStr.replaceAll('%', '').toString();
                          if(valueStr.contains('nan'))valueStr = valueStr.replaceAll('nan', '').toString();
                          if(valueStr.contains(' '))valueStr = valueStr.replaceAll(' ', '').toString();
                          if(valueStr=='' || valueStr==null)valueStr = '0';
                          double doubleValue = double.parse(valueStr);
                          var spot = ScatterSpot(i, doubleValue);
                          chart.add(spot);
                          i+=1;
                        });
                        return Container(
                          decoration: BoxDecoration(
                              color: MyColor.white75,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: index<=snapshot.data!.snapshot!.children.length-2?EdgeInsets.only(bottom: 10):EdgeInsets.only(bottom: 0),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text('$name',style: MyTextStyle.normalWithColor(MyColor.darkBlue),),
                                  Text('$val',style: MyTextStyle.normalWithColor(MyColor.darkBlue),),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Divider(height: 1,thickness: 1,),
                              const SizedBox(height: 10,),
                              Container(
                                height: 300,
                                child: LineChart(
                                  LineChartData(
                                    borderData: FlBorderData(show: false),
                                    lineTouchData: LineTouchData(enabled: true),
                                    lineBarsData: [
                                      LineChartBarData(
                                          spots:chart,
                                          isCurved: true,
                                          barWidth: 2,
                                          color: MyColor.green,
                                          belowBarData: BarAreaData(
                                              show: true,
                                              color: Colors.orange.withOpacity(0.05),
                                              cutOffY: cutOffYValue,
                                              applyCutOffY: true
                                          ),
                                          dotData: FlDotData(
                                              show: false
                                          )
                                      )
                                    ],
                                    minY: 0,
                                    minX: 0,
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 10,
                                            getTitlesWidget: (value, meta){
                                            return const Padding(padding: EdgeInsets.all(10));
                                            }
                                        )
                                      ),
                                      topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: false,
                                          )
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          getTitlesWidget: (value, meta) {
                                            String fullkey = limitKeyList.elementAt(value.toInt());
                                            String time = '';
                                            for(int i=11;i<=15;i++){
                                              time+=fullkey[i];
                                            }
                                            Widget w = Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('$time',style: const TextStyle(
                                                fontSize: MyFontSize.tiny,
                                                color: MyColor.green
                                              ),),
                                            );
                                            return w;
                                          },
                                          showTitles: true,
                                          reservedSize: 30,
                                          interval: limitKeyList.length/4
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: 300,
                              //   child: LineChart(
                              //     LineChartData(borderData: FlBorderData(show: false),
                              //         lineBarsData: [
                              //           LineChartBarData(
                              //               spots: chart
                              //           )
                              //         ]
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      }
                    });
              }

            }
            else{
              return const Center(child: CircularProgressIndicator());
            }
          }

      ),
    );
  }
}
