


import 'package:aqua/Custom_widget.dart';
import 'package:aqua/stats/Descriptive.dart';
import 'package:aqua/stats/PDF.dart';

import 'package:aqua/variables.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



class BoxPlot extends StatefulWidget {
  const BoxPlot({Key? key}) : super(key: key);

  @override
  State<BoxPlot> createState() => _BoxPlotState();
}

class _BoxPlotState extends State<BoxPlot> {
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(valueListenable: chart, 
        builder: (BuildContext context, value,_){

      if(sum_stat.isNotEmpty){
      if(value=='DensityPlot'){
        return const Box();
      }
      return const His();
        }
    return const SizedBox();}




    );

  }
}



class Box extends StatefulWidget {
  const Box({Key? key}) : super(key: key);

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {

  @override
  Widget build(BuildContext context) {
    // Define the data for the box plot
    try {
    return ValueListenableBuilder(
        valueListenable: cht,
        builder: (context, value, _) {
          var name = sum_stat["Para"];

          List dat = cvt(Descriptive_Statistics().Remove_Null(

              data(sum_stat['ID'], sum_stat['Para'])));

          if (dat.isEmpty) {
            return SizedBox();
          }

          double minx = Descriptive_Statistics().min(dat) -
              0.2 * Descriptive_Statistics().min(dat);
          double maxx = Descriptive_Statistics().max(dat) +
              0.2 * Descriptive_Statistics().max(dat);
          double step = bandwith.value / 10;
          List<FlSpot> kde = computeKDE(
              convertDynamicToDouble(dat), bandwith.value, minx, maxx, step);


          List<double> xValues = kde.map((spot) => spot.x).toList();
          List<double> yValues = kde.map((spot) => spot.y).toList();


          return LineChart(LineChartData(
              maxY: Descriptive_Statistics().max(yValues) +
                  0.05 * Descriptive_Statistics().max(yValues),
              maxX: Descriptive_Statistics().max(xValues) +
                  0.02 * Descriptive_Statistics().max(xValues),
              lineBarsData: [
                LineChartBarData(
                  spots: kde,
                  isCurved: true,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                      show: true, color: Colors.blue.withOpacity(0.3)),
                  dotData: const FlDotData(show: false),
                )
              ],
              titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                      axisNameWidget: Customtext('$name', Colors.black),
                      sideTitles: const SideTitles(
                          showTitles: true, reservedSize: 55))
              )
          )
          );
        }
    );
  }
    catch(e){
      return Center(child: Customtext('Something Went Wrong\n Ensure configuration is done correctly', Colors.red),);
    }



  }
}


  class His extends StatefulWidget {
  const His({Key? key}) : super(key: key);

  @override
  State<His> createState() => _HisState();
}

class _HisState extends State<His> {

  @override
  Widget build(BuildContext context) {
    try {
      return ValueListenableBuilder(
          valueListenable: cht,
          builder: (context, value, _) {
            var name = sum_stat["Para"];
            final List chartData = [];
            List dat = Descriptive_Statistics().Remove_Null(
                data(sum_stat['ID'], sum_stat['Para']));
            for (double tt in todoudlelist(dat)) {
              chartData.add(tt);
            }
            double max = Descriptive_Statistics().max(chartData);

            if (chartData.isEmpty) {
              return const SizedBox();
            }
            return BarChart(BarChartData(

                alignment: BarChartAlignment.center,
                maxY: max + 0.1 * max,
                barGroups: List.generate(chartData.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barsSpace: 0.0,
                    barRods: [
                      BarChartRodData(
                        toY: chartData[index].toDouble(),
                        color: Colors.blue,
                        width: 30,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  );
                }),


                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),

                  ),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)
                  ),
                  leftTitles: AxisTitles(
                      axisNameWidget: Customtext('$name', Colors.black),
                      sideTitles: const SideTitles(
                          showTitles: true, reservedSize: 32)),
                  bottomTitles: AxisTitles(
                      axisNameWidget: Customtext('values', Colors.black),
                      sideTitles: const SideTitles(
                          showTitles: true, reservedSize: 32)),

                )
            )
            );
          }
      );
    }
    catch(e){
      return Center(child: Customtext('Something Went Wrong\n Ensure configuration is done correctly', Colors.red),);
    }


  }
}




class ChartSampleData {
  final List<num> yValues;

  ChartSampleData({required this.yValues});
}


List<double> todoudlelist(List list){

  List<double> rr=[];
  for(var x in list){
    if(x!=null){
    rr.add(double.parse(x));
    }
  }

  return rr;
}







List<double> convertDynamicToDouble(List<dynamic> list) {
  return list.cast<double>();
}


List<double>cvt(List list){
  List<double>out=[];
  for(var x in list){
    out.add(double.parse(x));
  }

  return out;
}