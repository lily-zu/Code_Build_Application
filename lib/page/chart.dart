import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic_system/constants.dart';
class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            LineCharts(),
            Padding(padding: EdgeInsets.all(10),
            child: Text('PH Value')
              ,)
          ],
        ),
      ),
    );
  }
}

class LineCharts extends StatelessWidget {
  const LineCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 0.0;
    const textStyle = MyTextStyle.title;
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots:[
                FlSpot(1,4),
                FlSpot(2,2),
                FlSpot(3,3),
                FlSpot(4,4),
                FlSpot(5,6),
                FlSpot(6,2),
                FlSpot(7,3),
              ],
              isCurved: true,
              barWidth: 2,
              color: MyColor.black,
              belowBarData: BarAreaData(
                show: true,
                color: MyColor.sky.withOpacity(0.5),
                cutOffY: cutOffYValue,
                applyCutOffY: true
              ),
              dotData: FlDotData(
                show: true
              )
            )
          ],
          minY: 0,
          titlesData: FlTitlesData(
            // bottomTitles: SideTitles(
            //   showTitles: true,
            //   reservedSize: 5,
            // ),
            // leftTitles: SideTitles(
            //   showTitles: true,
            //   getTitlesWidget: Text('Chart'),
            // ),

          ),


        ),

      ),
    );
  }
}

