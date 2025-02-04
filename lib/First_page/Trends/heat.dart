

import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/WQI.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as ff;

import '../../imported_data_info/imported_data_info.dart';
import '../../variables.dart';

class Heat extends StatefulWidget {
  const Heat({Key? key}) : super(key: key);

  @override
  State<Heat> createState() => _HeatState();
}

class _HeatState extends State<Heat> {
  @override

  Widget build(BuildContext context) {
    List paras=parameters.keys.toList();
    if(input_info['ID']!=null){
      paras.remove(input_info['ID']);

    }
    if(input_info['Date']!=null){
      paras.remove(input_info['Date']);
    }

    int size=conf.keys.toList().length;
    if(size==paras.length){
      ht.value=1;
    }



    return ValueListenableBuilder(valueListenable: ht, builder: (context,val,_){
      if(val==0){
        return Center(child: Customtext('Something Went Wrong. \n Complete Configuration', Colors.red),);
      }
      try{
      return Column(
        children: [
          Customtext('Heat Map', Colors.black),
          ff.Divider(color: Colors.blue,height: 5,),
          Expanded(
            child: FutureBuilder(
              future: WQI(),
              builder: (context,snp){
                if(snp.hasData){
                  List<Widget> grid=[];
                  for(var x in snp.data!.keys){
                    grid.add(
                      Container(
                        color: color(snp.data![x]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Customtext('$x', Colors.black),
                            Center(child: Customtext('${snp.data![x].toStringAsFixed(2)}', Colors.black)),
                          ],
                        ),
                      )
                    );
                  }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: grid,
                ),
              );
                }else{
                  return const SizedBox();
                }
            
              }
            ),
          ),
        ],
      );
      }
      catch(r){
        return Center(child: Customtext('Something Went Wrong. \n Complete Configuration', Colors.red),);
      }
    });
  }
}



Color color(double wqi){
  if(wqi<=25){
    return Colors.green;
  }
  else if(wqi> 25 && wqi <=50){
    return ff.Colors.lightGreen;
  }
  else if(wqi> 50 && wqi <=75){
    return Colors.yellow;
  }
  else if(wqi> 76 && wqi <=100){
    return Colors.orange;
  }
  return Colors.red;
}
