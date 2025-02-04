


import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/filterd_data.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import 'package:flutter/material.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';


import '../../variables.dart';
List linedatalist=[];

List names=[];

class Linechart extends StatefulWidget {
  const Linechart({Key? key}) : super(key: key);

  @override
  State<Linechart> createState() => _LinechartState();
}

class _LinechartState extends State<Linechart> {
  @override
  Widget build(BuildContext context) {
    var source=input_info['Source'];
    List<DateTime?> _dates=[];
    String timedate='';
    List time=[];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Customtext('Water Source: $source', Colors.black),
            ft.Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: HoverOutlineButton(text: 'Reset', onPressed: (){
                linedatalist=[];
                datetype=true;
                integer.value++;
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8),
              child: HoverOutlineButton(text: 'Add Data', onPressed: (){
                List<ft.MenuFlyoutItem> parameteritem=[];
                List<ft.MenuFlyoutItem>iditem=[];
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
                        paramitems.value='Parameter: $items';
                      }
                    )
                  );
                }

                for(var xx in parameters[input_info['ID']].toSet().toList()){
                  iditem.add(
                    ft.MenuFlyoutItem(
                      text: Customtext('$xx', Colors.black),
                      onPressed: (){
                        chartid.value='Selected ID: $xx';
                      }
                    )
                  );
                }


                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {


                    Widget upper(){

                      if(id_check==''&& datetype){
                       return ft.ListView(


                          shrinkWrap: true,


                          children: [
                            Customtext('Choose duration type: Data or Time', Colors.black),
                            const ft.SizedBox(height: 10,),


                            GroupButton(
                              onSelected: (i,selected,fa)=>timedate=i,
                              isRadio: true,

                              buttons: const ['Time','Date','Date/Time'],
                            )




                          ],
                        );

                      }else{
                      return const ft.SizedBox();}
                    }




                    return ft.ContentDialog(
                      title: const Text('Add Data'),
                      content: ft.ListView(
                        shrinkWrap: true,
                        children: [

                          Material(
                            child: upper()
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ft.DropDownButton(
                            title: Changing_text(value: paramitems),
                            items: parameteritem,
                          ),
                          const ft.SizedBox(
                            height: 10,
                          ),
                          ft.DropDownButton(
                            title: Changing_text(value: chartid),
                            items: iditem,
                          ),
                          const ft.SizedBox(height: 10,),
                          HoverOutlineButton(text: 'Select Time/Date Range', onPressed: ()async{

                            if(timedate=='Date'){
                            var results = await showCalendarDatePicker2Dialog(
                            context: context,

                            barrierColor: Colors.blue,
                            dialogBackgroundColor: Colors.white,

                            config: CalendarDatePicker2WithActionButtonsConfig(
                              calendarType:  CalendarDatePicker2Type.range,
                            ),


                            dialogSize: const Size(325, 400),
                            value: _dates,
                            borderRadius: BorderRadius.circular(15),



                            );
                            _dates=results!;

                            }else if(timedate=='Time'){
                            showDialog(context: context,
                              builder: (_)=> FromToTimePicker(
                                onTab: (from,to){
                                  time.add(from.hour);
                                  time.add(to.hour);
                                },
                                dialogBackgroundColor: Colors.white,
                                doneText: 'Okay',

                                dismissTextColor: Colors.blue,


                              )

                            );

                            }



                          })
                        ],
                      ),
                      actions: [
                        HoverOutlineButton(text: 'Proceed', onPressed: (){
                          //prepare data and add to list
                          if(timedate!='' && paramitems.value!='Select a Parameter!' && chartid.value!='Select an ID' ){
                            print(1);

                            if(_dates.isNotEmpty || time.isNotEmpty) {

                                linedatalist.add(FilteredData(chartid.value.toString(), paramitems.value.toString(), timedate, timedate=='Date'?_dates:time));
                                //LineList.value=linedatalist;

                                integer.value++;
                                names.add(paramitems.value);
                                datetype = false;






                              Navigator.pop(context);

                            }
                          }
                        }),
                        HoverOutlineButton(text: 'Cancel', onPressed: (){

                          Navigator.of(context).pop();
                        })
                      ],
                    );
                  },
                );

              }),
            )
          ],
        ),
        const Divider(
          color: Colors.blue,
        ),
        const Expanded(child: ShowLineChart())
      ],
    );
  }
}



class ShowLineChart extends StatefulWidget {
  const ShowLineChart({Key? key}) : super(key: key);

  @override
  State<ShowLineChart> createState() => _ShowLineChartState();
}

class _ShowLineChartState extends State<ShowLineChart> {


  @override
  Widget build(BuildContext context) {
    List<Color> cl=[Colors.blue,Colors.green,Colors.pink,Colors.amber];

    

    if(input_info['Date']==null){
      return ft.Center(child: Customtext('Data has no Time/Date column', Colors.red));
    }


    return  ValueListenableBuilder<int>(
      valueListenable: integer,
      builder: (BuildContext context, value, _) {
        List<LineChartBarData> Lines=[];
        int clo=0;

        for(var x in linedatalist){
          int counter=0;
          List<FlSpot> temp=[];
          for(var i in x[0]){
            temp.add(FlSpot(x[1][counter],double.parse(i)));
            counter++;
          }


          Lines.add(
            LineChartBarData(
              spots: temp,
              isCurved: true,
              barWidth: 4,
              isStrokeCapRound: true,
              color: clo<cl.length?cl[clo]:Colors.black
            )
          );
          clo++;
        }


      return ft.Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(

            lineBarsData: Lines,

            titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: Customtext("Value", Colors.black),
                  sideTitles: const SideTitles(
                    reservedSize: 45,
                    showTitles: true,

                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Customtext("Date/Time", Colors.black),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,

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
                ),

                topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: false
                    )
                ),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: false,reservedSize: 20
                    )
                )
            ),
          )
        ),
      );
      },
    );



  }}
