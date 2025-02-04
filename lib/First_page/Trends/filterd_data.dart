import 'dart:math';

import 'package:aqua/First_page/Trends/TimeFomart.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/stats/Descriptive.dart';
import 'package:aqua/variables.dart';

List FilteredData(String ID , String Parameter, String Datetype, List range){
  List dt=[];
  List indexes=[];
  //get index of all ID
  List id=parameters[input_info['ID']];
  int counter=0;
  for(var x in id){

    if(x==ID.substring(13)){
      indexes.add(counter);
    }

    counter++;

  }

  List new_parameter=[];

  String z=Parameter.substring(11);

  for(int x in indexes){
    new_parameter.add(parameters[input_info['Date']][x]);
  }



  if(Datetype=='Date'){
    List l=Change_TimeDateFormat(range, 'Date');

    List Dates=Formart_date(new_parameter);
    dt=Formart_date(new_parameter);
    int ter=0;
    // get date within range

    if(l.length==1){

      for(double gg in Dates){

        if(gg<l[0]){
          dt.remove(gg);

          indexes.removeAt(ter);


        }
        else{
          ter++;
        }


      }
    }
    else{
      for(double gg in Dates){
        if(gg<l[0] || gg>l[1]){
          dt.remove(gg);

          indexes.removeAt(ter);
        }
        else{
          ter++;
        }

      }
    }




  }
  else if(Datetype=='Time'){
    List new_range=[];

    for(var x in range){
      new_range.add(numbertime(x));
    }
    List new_date=Format_time(new_parameter);
    dt=Format_time(new_parameter);
    int ter=0;

    for(double gg in new_date){
      if(gg<new_range[0] || gg>new_range[1]){
        dt.remove(gg);

        indexes.removeAt(ter);
      }else{
        ter++;
      }

    }


  }

  List plot_data=[];

  List preferd_parameter=parameters[z];

  for(var parameters in indexes){
    plot_data.add(preferd_parameter[parameters]);



  }




  return Nullremoval([plot_data,dt]);
  //return [[2.0,3.0,1.0,4.0,6.0],['11','10','5','12','2']];

}


List Nullremoval(List list){
  List first=list[0];

  List second=list.last;
  int len=first.length;
  int counter=0;
  int co=0;
  print(len);
  while(counter<len){
    print(co);
    if(first[co]==null || first[co]==' '|| first[co]==''){
      first.removeAt(co);
      second.removeAt(co);
    }else{
      co++;
    }
    counter++;

  }
  len=second.length;
  co=0;
  counter=0;
  while(counter<len){
    if(second[co]==null || second[co]==' '|| second[co]==''){
      first.removeAt(co);
      second.removeAt(co);
    }
    else{
      co++;
    }
    counter++;
  }


  return [first,second];

}


DateTime X_cordinate(double list){

  DateTime date = DateTime.fromMillisecondsSinceEpoch(list.toInt());

  return DateTime(date.year,date.month,date.day,date.hour,date.minute);
}