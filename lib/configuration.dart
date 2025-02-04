

import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/WQI.dart';
import 'package:aqua/SQL_imp.dart';
import 'package:aqua/variables.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as ft;

import 'imported_data_info/imported_data_info.dart';

class Configuration extends StatefulWidget {
  const Configuration({Key? key}) : super(key: key);

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(

      padding: EdgeInsets.zero,


      header: Container(
        color: Colors.blue,
        child: PageHeader(
          title: Customtext('Configuration', Colors.white),
          leading: IconButton(icon: const Icon(FluentIcons.back,color: Colors.white,size: 30,), onPressed: (){
            Navigator.pop(context);
          }),
          commandBar: ValueListenableBuilder(
            valueListenable: stdname,
            builder: (context,vl,_){
              return FutureBuilder(
                  future: getAllTable(),
                  builder: (context,val){
                    if(val.hasData){
                      List<ft.DropdownMenuEntry> data=[];
                      for(var xx in val.data!){
                        data.add(ft.DropdownMenuEntry(value: xx,label: xx));
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ft.Material(
                          child: ft.DropdownMenu(
                            hintText: vl,
                            dropdownMenuEntries: data,
                            onSelected: (i){
                              stdname.value=i;
                            },
                          ),
                        ),
                      );
                    }else{
                      return const ft.CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 5,
                      );
                    }


                  }
              );
            }

          ),

        ),
      ),
      content: Container(
        color: Colors.white,
        child: const Futurebody(),
      ),
    );
  }
}

class Futurebody extends StatefulWidget {
  const Futurebody({Key? key}) : super(key: key);

  @override
  State<Futurebody> createState() => _FuturebodyState();
}

class _FuturebodyState extends State<Futurebody> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: stdname,
      builder: (context,vv,_){
      return FutureBuilder(future: modified(tablename: vv), builder: (context,snp){
      if(snp.hasData){
        List<Widget> cldn=[];
        List yy=parameters.keys.toList();

        if(input_info['ID']!=null){
          yy.remove(input_info['ID']);

        }
        if(input_info['Date']!=null){
          yy.remove(input_info['Date']);
        }
        List<ft.DropdownMenuEntry>ent=[];
        for(var rf in snp.data!){
          ent.add(
            ft.DropdownMenuEntry(value: rf,
              label: rf,
            )
          );
        }

        for(var x in yy){
          cldn.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Customtext(x, Colors.black),
              ft.Material(child: ft.DropdownMenu(dropdownMenuEntries: ent,
              hintText: 'Select A Parameter',
                inputDecorationTheme: const ft.InputDecorationTheme(

                ),
                enableSearch: true,

                onSelected: (val){
                conf[x]=val;
                },


              ))
            ],
          ));
          cldn.add(const Divider());



        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: cldn,
            
            ),
          ),
        );
      }
      else {
        return const SizedBox();
      }
    });
  }
    );

  }
}



