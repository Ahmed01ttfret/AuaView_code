


import 'package:aqua/First_page/WaterSource.dart';
import 'package:aqua/configuration.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:fluent_ui/fluent_ui.dart' as ft;

import 'package:flutter/material.dart';

import '../../../Custom_widget.dart';
import '../../../variables.dart';

class Info_For_Imported_file extends StatefulWidget {
  const Info_For_Imported_file({Key? key}) : super(key: key);

  @override
  State<Info_For_Imported_file> createState() => _Info_For_Imported_fileState();
}

class _Info_For_Imported_fileState extends State<Info_For_Imported_file> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List>(valueListenable: info_,
      builder: (BuildContext context,value,build){

      String name =value[0];
      String size =value[1];
      String path =value[2];
      String noParameters=value[3];

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Customtext('File Name: $name',Colors.black),
            Customtext('Path: $path',Colors.black),
            Customtext('Size: $size',Colors.black),
            Customtext('Number of Parameters: $noParameters',Colors.black),
            const SizedBox( height: 40),
            HoverOutlineButton(text: 'Type/Source of water', onPressed: (){
              showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    // false = user must tap button, true = tap outside dialog
                    builder: (BuildContext dialogContext) {
                      return ft.ContentDialog(
                        title: Customtext('Water Type/Source', Colors.black),
                        content: ft.ListView(shrinkWrap: true,children: const [ Watersource()],),
                       actions: <Widget>[

                          HoverOutlineButton(text: 'Cancel', onPressed: (){
                            Navigator.pop(context);
                          })
                       ],
                     );
                    },
                  );
                }),
           ValueListenableBuilder<List>(
              valueListenable:drop,
              builder: (context,val,_){

               List<ft.MenuFlyoutItemBase> it=[];

                if(val.isNotEmpty){
                  for(var x in val[0]){
                    it.add(
                        ft.MenuFlyoutItem(
                            text: Customtext('$x', Colors.black),
                            onPressed: (){
                              setState(() {
                                option='Date/Time column is $x';
                                drop.value.remove(x);
                                input_info['Date']=x;




                              });
                            }
                        )
                    );
                  }
                }

                return Padding(
                  
                  padding: const EdgeInsets.only(top: 10),
                  child: ft.DropDownButton(

                  title: Customtext(option, Colors.black),
                  items: it,
                                ),
                );
      }
            ),


            ValueListenableBuilder<List>(
                valueListenable:drop,
                builder: (context,val,_){

                  List<ft.MenuFlyoutItemBase> its=[];

                  if(val.isNotEmpty){
                    for(var i in val[0]){
                      its.add(
                          ft.MenuFlyoutItem(
                              text: Customtext('$i', Colors.black),
                              onPressed: (){
                                setState(() {
                                option1='ID column is $i';
                                drop.value.remove(i);
                                input_info['ID']=i;




                                });
                              }
                          )
                      );
                    }
                  }

                  return Padding(

                    padding: EdgeInsets.only(top: 10),
                    child: ft.DropDownButton(

                      title: Customtext(option1, Colors.black),
                      items: its,
                    ),
                  );
                }
            ),
            const ft.SizedBox(height: 10,),
            HoverOutlineButton(text: 'Configurations', onPressed: (){
              Navigator.push(
                context,
                ft.FluentPageRoute(builder: (context) => const Configuration()),
              );
            })
            

          ],
        ),
      );}
    );
  }
}
