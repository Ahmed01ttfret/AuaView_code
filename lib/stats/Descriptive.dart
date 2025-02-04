/*
will show mean, sd , varience , Basic Counts, Percentage of Missing Values, units, Sampling Date Range  ,quatiles



 */

import 'dart:math';

import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/variables.dart';
class Descriptive_Statistics {
  double mean(List list) {
    list=Remove_Null(list);
    return sum(list) / list.length;
  }


  double sum(List list) {

    num initial = 0;

    for (var x in list) {
      if(x.runtimeType==String){
        x=double.parse(x);
      }

      initial = initial + x;
    }

    return initial.toDouble();
  }


  int count(List list) {
    return list.length;
  }


  int Number_of_null(List list) {
    int count = 0;
    for (var x in list) {
      if (x == null || x=='' || x==Null) {
        count += 1;
      }
    }

    return count;
  }

  double Varience(List list) {
    list=Remove_Null(list);
    int N = count(list)-1;
    double X = mean(list);
    List manup = [];
    for (var x in list) {
      num i = x - X;
      manup.add(pow(i, 2));
    }

    return sum(manup) / N;
  }

  double SD(List list) {
    return sqrt(Varience(list));
  }

  Map quatile(List list) {
    num q1 = 0;
    num q2 = 0;
    num q3 = 0;
    list=Remove_Null(list);
    list.sort();
    q2 = Median(list);
    if (list.length.isOdd) {
      num l = (list.length + 1) / 2;

      q1 = Median(list.sublist(0, l.toInt() - 1));
      q3 = Median(list.sublist(l.toInt()));
    } else {
      num x = list.length / 2 - 1;
      q1 = Median(list.sublist(0, x.toInt()));
      q3 = Median(list.sublist(x.toInt() + 2));
    }


    return {'q1': q1, 'q2': q2, 'q3': q3};
  }

  num Median(List list) {
    list=Remove_Null(list);
    if (list.length.isOdd) {
      if (list.length != 1) {
        double pos = (list.length + 1) / 2;
        pos = pos - 1;
        return list[pos.toInt()];
      } else {
        return list[0];
      }
    } else {
      num first = list.length / 2;
      num second = first - 1;
      return (list[first.toInt()] + list[second.toInt()]) / 2;
    }
  }


  List<dynamic> Remove_Null(List<dynamic> list) {
    List<dynamic> in_list = [];

    for (var x in list) {
      if (x != null && x != '') {
        in_list.add(x);
      }
    }

    return in_list;
  }


  double max(List list){
    if(list.isNotEmpty){
    double t=list[0];

    for(var x in list){
      if(x>t){
        t=x;
      }
    }
    return t;
    }
    return 0.0;
  }


  double min(List list){

    double t=list[0];

    for(var x in list){

      if(x<t){
        t=x;
      }
    }
    return t;
  }


}

List data(String id, String f){
  var ids=input_info['ID'];
  ids=parameters[ids];

  int count=0;
  List index=[];
  for(var x in ids){
    if(x.toString()==id){

      index.add(count);
    }
    count++;
  }

  List new_list=[];

  List pa=parameters[f];

  for(int t in index){
    new_list.add(pa[t]);
  }

  return new_list;
}


