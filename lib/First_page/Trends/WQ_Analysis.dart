


import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/WQI.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../imported_data_info/imported_data_info.dart';
import '../../variables.dart';
import 'TimeFomart.dart';

String IdName='';

class WqAnalysis extends StatefulWidget {
  const WqAnalysis({Key? key}) : super(key: key);

  @override
  State<WqAnalysis> createState() => _WqAnalysisState();
}

class _WqAnalysisState extends State<WqAnalysis> {
  @override
  Widget build(BuildContext context) {
    try{
    return const Column(
      children: [
        Top(),
        Divider(color: Colors.blue,height: 5,),
        Expanded(child: WQIBody())
      ],
    );}
        catch(r){
          return Center(child: chartContainer(Customtext('Something Went Wrong \n Complete Configuration', Colors.red)));
        }
  }
}


class Top extends StatefulWidget {
  const Top({Key? key}) : super(key: key);

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {

    List paras=parameters[input_info['ID']];
    paras=paras.toSet().toList();


    List<DropdownMenuEntry> entry=[];
    for(var x in paras){
      entry.add(
        DropdownMenuEntry(value: x, label: x,)
      );
    }
    IdName=paras[0];


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Customtext('WQI Trend Analysis', Colors.black),
        Material(
          child: DropdownMenu(dropdownMenuEntries: entry,
          hintText: '${paras[0]}',onSelected: (x){
            IdName=x;
            ht.value++;

            },),
        )
      ],
    );
  }
}



class WQIBody extends StatefulWidget {
  const WQIBody({Key? key}) : super(key: key);

  @override
  State<WQIBody> createState() => _WQIBodyState();
}

class _WQIBodyState extends State<WQIBody> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: ht, builder: (context,val,_){


      if(val==0){
        return Center(child: Customtext('Something Went Wrong. \n Complete Configuration', Colors.red),);
      }
      return FutureBuilder(
        future: WQA(IdName),
        builder: (context , snapshot){
          if(snapshot.hasData){
            List<FlSpot> ris=[];


            for(var x in snapshot.data!.keys){
              ris.add(
                FlSpot(chg(x).millisecondsSinceEpoch.toDouble(), snapshot.data![x])
              );
            }


          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Customtext('WQI',Colors.black),
                    sideTitles: const SideTitles(showTitles: true,
                    reservedSize: 45),

                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Customtext('Date', Colors.black),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 45,

                      getTitlesWidget: (double value, TitleMeta meta) {
                        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt());

                        // Format the DateTime to a readable string (e.g., "March 2011")


                        String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);


                        return Transform.rotate(
                          angle: -45 * 3.1415927 / 180, // Rotate by 45 degrees in radians
                          child: Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: ris,
                      isCurved: true,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      color: Colors.deepOrange,
                  )
                ]

              )
            ),
          );


          }else{
            return  const CircularProgressIndicator();
          }
    }
      );
    });
  }
}



DateTime chg(String date){
  if(date.contains('Z')){
    return numi(date.substring(0,10).split('-'));

  }
  else{
    List r=date.split('/');
    return DateTime(r[2],r[1],r[0]);
  }
}


