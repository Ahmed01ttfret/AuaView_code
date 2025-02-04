

import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/filterd_data.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';


import '../../imported_data_info/imported_data_info.dart';
import '../../variables.dart';
List scatterdatat=[];
class ScatterPlot extends StatefulWidget {
  const ScatterPlot({Key? key}) : super(key: key);

  @override
  State<ScatterPlot> createState() => _ScatterPlotState();
}

class _ScatterPlotState extends State<ScatterPlot> {
  @override
  Widget build(BuildContext context) {
    List<ft.MenuFlyoutItem> parameteritem=[];
    List<ft.MenuFlyoutItem> pary=[];
    List paras=parameters.keys.toList();
    if(input_info['ID']!=null){
      paras.remove(input_info['ID']);

    }
    if(input_info['Date']!=null){
      paras.remove(input_info['Date']);
    }


    for(var items in paras){
      parameteritem.add(
          ft.MenuFlyoutItem(
              text: Customtext('$items', Colors.black),
              onPressed: (){
                X.value='$items';
              }
          )
      );
    }



    for(var items in paras){
      pary.add(
          ft.MenuFlyoutItem(
              text: Customtext('$items', Colors.black),
              onPressed: (){
                Y.value='$items';
              }
          )
      );
    }




    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Customtext('Correlation /Scatter Plot', Colors.black),
              ft.ValueListenableBuilder(
                valueListenable: Buttontext,
                builder: (BuildContext context ,value,_){
                return HoverOutlineButton(text: value==true?'Add Data':'Reset', onPressed: (){
                  if(Buttontext.value==true) {
                    showDialog(context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return ft.ContentDialog(
                            actions: [
                              HoverOutlineButton(text: 'Cancel', onPressed: () {
                                Navigator.pop(context);
                              }),
                              HoverOutlineButton(
                                  text: 'Proceed', onPressed: () {
                                if (X.value != 'Select X parameter' &&
                                    Y.value != 'Select Y parameter') {
                                  Buttontext.value = false;
                                  Navigator.pop(context);
                                  scatterdatat=Nullremoval([parameters[X.value],parameters[Y.value]]);
                                  int2.value++;
                                }
                              })
                            ],
                            content: ft.ListView(
                              shrinkWrap: true,
                              children: [
                                ft.DropDownButton(
                                  items: parameteritem,
                                  title: Changing_text(value: X,),
                                ),
                                const ft.SizedBox(height: 10,),
                                ft.DropDownButton(
                                  title: Changing_text(value: Y,),
                                  items: pary,
                                )
                              ],
                            ),
                          );
                        });
                  }else{
                    Buttontext.value=true;
                    scatterdatat=[];
                    int2.value++;
                  }
                });}
              ),

            ],
          ),
        ),
        const Divider(color: Colors.blue,),
        const ft.Expanded(child: Sct())

      ],
    );
  }
}





class Sct extends StatefulWidget {
  const Sct({Key? key}) : super(key: key);

  @override
  State<Sct> createState() => _SctState();
}

class _SctState extends State<Sct> {



  @override
  Widget build(BuildContext context) {

    return ft.Padding(
      padding: const EdgeInsets.only(right: 8,bottom: 10),
      child: ft.ValueListenableBuilder(valueListenable: int2, builder: (ft.BuildContext context, value,_){
        double smallX=scatterdatat.isNotEmpty? findSmallestNumber(scatterdatat[0]):0;
        double smallY=scatterdatat.isNotEmpty? findSmallestNumber(scatterdatat[1]):0;
        double? bigX= scatterdatat.isNotEmpty?LargestNumber(scatterdatat[0]):1;
        double? bigY=scatterdatat.isNotEmpty? LargestNumber(scatterdatat[1]):1 ;

        List<ScatterSpot> Data=[];
        int couter=0;
        if(scatterdatat.isNotEmpty){
        for(var x in scatterdatat[0]){
          Data.add(ScatterSpot(double.parse(x), double.parse(scatterdatat[1][couter]),dotPainter: FlDotCirclePainter(color: Colors.blue,strokeWidth: 2)));
          couter++;
        }}
        return ScatterChart(

          ScatterChartData(

            maxX: bigX!+tw(bigX),
            minY: smallY,
            maxY: bigY!+tw(bigY),
            minX: smallX,

            gridData: FlGridData(
              show: false,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) => const FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              ),
              getDrawingVerticalLine: (value) => const FlLine(
                color: Colors.grey,
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                axisNameWidget: Customtext(Y.value,Colors.black),
                sideTitles: const SideTitles(showTitles: true,reservedSize: 42),

              ),
              bottomTitles: AxisTitles(
                axisNameWidget: Customtext(X.value, Colors.black),
                sideTitles: const SideTitles(showTitles: true,reservedSize: 32),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)
              )
            ),
            scatterSpots:Data,
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black),
            ),


          ),



        );



      }),
    );
  }
}





double findSmallestNumber(List stringList) {
  if (stringList.isEmpty) {
    throw ArgumentError("The list cannot be empty.");
  }

  try {
    // Convert the list of strings to a list of doubles
    List<double> numbers = stringList.map((str) => double.parse(str)).toList();

    // Find and return the smallest number
    return numbers.reduce((value, element) => value < element ? value : element);
  } catch (e) {
    throw ArgumentError("The list contains invalid numbers: $e");
  }
}


double? LargestNumber(List stringList) {
  // Convert the list of strings to a list of doubles
  try {
    List<double> numbers = stringList.map((e) => double.parse(e)).toList();

    // Return the largest number using the fold method
    return numbers.isEmpty ? null : numbers.fold(numbers[0], (a, b) => a! > b ? a : b);
  } catch (e) {
    // Return null if any string is not a valid number
    print('Error: List contains invalid number(s) or is empty.');
    return null;
  }
}


double tw(double x){
  return 0.15*x;
}

