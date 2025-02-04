


import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/WQI.dart';
import 'package:aqua/SQL_imp.dart';
import 'package:aqua/variables.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;
import '../../../imported_data_info/imported_data_info.dart';

class ParameterAndStandards extends StatefulWidget {
  const ParameterAndStandards({Key? key}) : super(key: key);

  @override
  State<ParameterAndStandards> createState() => _ParameterAndStandardsState();
}

class _ParameterAndStandardsState extends State<ParameterAndStandards> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String>name=ValueNotifier('Parameters');
    Future<List> tbl()async{
      return getAllTables(await initializeDatabase());
    }

    Future<List> allpara()async{
      return getAllItems(await initializeDatabase(), name.value);
    }


    return FutureBuilder(future: tbl(), builder: (context,snp){
      if(snp.hasData){
        final ValueNotifier<String>id_name=ValueNotifier('');

        List paras=[''];
        if(input_info['ID']!=null){


          paras=parameters[input_info['ID']].toSet().toList();
          id_name.value=paras[0];

        }


        List<ft.MenuFlyoutItem> items=[];
        for(var standards in snp.data!){
          items.add(
            ft.MenuFlyoutItem(text: Customtext('$standards', Colors.black),
                onPressed: (){
              name.value=standards;
              int2.value++;

                })
          );
        }
        List<ft.MenuFlyoutItem> id=[];

        for(var ids in paras){
          id.add(
            ft.MenuFlyoutItem(text: Customtext('$ids', Colors.black),
            onPressed: (){
              id_name.value=ids;
              int2.value++;
            })
          );
        }



        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ft.DropDownButton(
                    items: items,
                    title: Changing_text(value: name),
                  ),
                  ft.DropDownButton(
                    items: id,
                    title: Changing_text(value: id_name,),
                  )
                ],
              ),
              const Divider(color: Colors.blue,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Customtext('Parameter', Colors.black),
                  Customtext('Value', Colors.black),
                  Customtext('Standard', Colors.black),
                  Customtext('Status', Colors.black),

                ],),
            const Divider(color: Colors.grey,),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: int2,
                  builder: (context,ll,_){
                  return FutureBuilder(future: allpara(), builder: (context,snapshot){

                    Color status(double standard, double value){
                      if(value<standard){
                        return Colors.green;
                      }
                      else if(value>standard){
                        return Colors.red;
                      }
                      return Colors.orange;
                    }

                    if(snapshot.hasData){
                      if(snapshot.data!.isEmpty){
                        return Center(child: Customtext('Something went wrong \n Standard ${name.value} has no parameters', Colors.red));
                      }

                      String standard_parameter(String name){

                        int count=0;
                        int index=0;
                        for(Map xx in snapshot.data!){

                          if(xx['parameter']==conf[name]){
                            index=count;

                          }

                          count++;
                        }

                        return snapshot.data![index]['Standard'].toString();
                      }
                      List<Widget> list=[];
                      Map average_of_parameters=Grouped_Id()[id_name.value];

                      for(var x in average_of_parameters.keys){
                        list.add(
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start, // Ensures proper alignment when height varies
                                children: [
                                  Expanded(
                                    child: Customtext('$x', Colors.black),
                                  ),
                                  Expanded(
                                    child: Customtext('${average_of_parameters[x]}', Colors.black),
                                  ),
                                  Expanded(
                                    child: Customtext(standard_parameter(x), Colors.black),
                                  ),
                                  SizedBox(
                                    width: 25, height: 25,
                                    child: Container(color: status(double.parse(standard_parameter(x)), average_of_parameters[x])),
                                  ),
                                ],
                              ),
                            )

                        );
                      }




                      //print(snapshot.data);


                      return ListView(
                        children: list,
                      );
                    }
                    return const CircularProgressIndicator(color: Colors.blue,);
                  });
                  }
                ),

              ),
            ],
          ),
        );
      }
      return const CircularProgressIndicator(
        color: Colors.blue,
      );
    });
  }
}

