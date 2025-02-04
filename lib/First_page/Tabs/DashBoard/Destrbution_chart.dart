

import 'package:aqua/Boxplot.dart';
import 'package:aqua/Custom_widget.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/variables.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;



class Destrbution_chart extends StatefulWidget {
  const Destrbution_chart({Key? key}) : super(key: key);

  @override
  State<Destrbution_chart> createState() => _Destrbution_chartState();
}

class _Destrbution_chartState extends State<Destrbution_chart> {
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ft.ValueListenableBuilder(
            valueListenable: chart,
            builder: (context,v,_){

              final TextEditingController txt=TextEditingController();
              List param = parameters[input_info['ID']].toSet().toList();
              List<ft.MenuFlyoutItem> item = [];
              for (var x in param) {
                item.add(
                    ft.MenuFlyoutItem(
                        text: Customtext('$x', Colors.black),
                        onPressed: () {
                          setState(() {
                            ids.value = x.toString();
                            if (sum_stat.isEmpty) {
                              temp = ids.value;
                            } else {
                              sum_stat['ID'] = ids.value;
                            }
                            cht.value++;
                          });

                          var tep = chart.value;
                          chart.value = '';
                          chart.value = tep;
                        }
                    )
                );
              }

              List<ft.MenuFlyoutItem> it = [];
              List key = parameters.keys.toList();
              if (input_info['ID'] != null) {
                key.remove(input_info['ID']);
              }
              if (input_info['Date'] != null) {
                key.remove(input_info['Date']);
              }

              for (var i in key) {
                it.add(

                    ft.MenuFlyoutItem(
                        text: Customtext('$i', Colors.black),
                        onPressed: () {
                          setState(() {
                            params.value = i.toString();
                            if (sum_stat.isEmpty) {
                              sum_stat['Para'] = params.value;
                              sum_stat['ID'] = temp;
                            }
                            else {
                              sum_stat['Para'] = params.value;
                            }
                          });

                          var tep = chart.value;
                          chart.value = '';
                          chart.value = tep;
                          cht.value++;
                        }
                    )

                );
              }



              return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ft.DropDownButton(
                  title: Changing_text(value: ids),
                  items: item,
                ),
                ft.DropDownButton(
                  title: Changing_text(value: params),
                  items: it,
                ),
                ft.DropDownButton(
                  title: Changing_text(value: chart),
                  items: [
                    ft.MenuFlyoutItem(
                      text: Customtext('DensityPlot', Colors.black),
                      onPressed: () {
                        chart.value = 'DensityPlot';
                      },
                    ),
                    ft.MenuFlyoutItem(
                      text: Customtext('Histogram', Colors.black),
                      onPressed: () {
                        chart.value = 'Histogram';
                      },
                    ),
                  ],
                ),
                chart.value == 'DensityPlot'
                    ? Container(
                  width: 200, // Constrain the width to prevent unbounded error
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ft.TextBox(
                          controller: txt,
                          placeholder: 'Bandwidth: ${bandwith.value}',
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if(txt.text.isNotEmpty){
                            if(num.tryParse(txt.text) != null){
                              bandwith.value=double.parse(txt.text);
                              cht.value++;
                            }
                          }
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                )
                    : const SizedBox(),
              ],
            );
  }
          ),
          const Divider(
            color: Colors.blue,
            thickness: 1,
          ),
          const Expanded(child: BoxPlot()),
        ],
      ),
    );
  }
  }
