import 'package:flutter/material.dart';

import '../constants.dart';

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
        onTap: (){
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const ChartDetailPage(),
          //   ),
          // );
        },
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: MyColor.white75,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Image(image: AssetImage(_image),width: 40,height: 40,fit: BoxFit.contain,),
                    Text('$value',style: MyTextStyle.normal,),
                  ],
                ),
                Text('$name',style: MyTextStyle.normal,),
              ],
            )
        ),
      ),
    );
  }
}
