

import 'package:aqua/imported_data_info/imported_data_info.dart';

List Change_TimeDateFormat(List timedate, String type){
  if(type=='Date'){
    List returntime=[];
    for(var x in timedate){
      x=x.toString();
      var date=x.split(' ')[0].split('-');
      returntime.add(numtime(date));


    }
    return returntime;
  }else if(type=='Time'){

  }
  return [];
}


DateTime numi(List l) {
  if(l.isNotEmpty) {
    DateTime now = DateTime(int.parse(l[0]), int.parse(l[1]), int.parse(l[2]));
    //DateTime time=DateTime(0,0,0,15,33);
    
    return now;
  }
  return DateTime(1);

}


double numtime(List l) {
  if(l.isNotEmpty) {
    DateTime now = DateTime(int.parse(l[0]), int.parse(l[1]), int.parse(l[2]));
    //DateTime time=DateTime(0,0,0,15,33);
    double epochTime = now.millisecondsSinceEpoch.toDouble();
    return epochTime;
  }
  return 0;

}

double numbertime(int l) {


    DateTime now=DateTime(0,0,0,l,0);
    double epochTime = now.millisecondsSinceEpoch.toDouble();
    return epochTime;

}


double numbertime2(List l) {


  DateTime now=DateTime(0,0,0,int.parse(l[0]),int.parse(l[1]));
  double epochTime = now.millisecondsSinceEpoch.toDouble();
  return epochTime;

}


List Formart_date(List list){
  String input_file=input_info['Name'];
  String ext=input_file.split('.').last;
  List new_date=[];

  if(ext=='xlsx'){
    for(String dates in list){
      if(dates.isNotEmpty){

      new_date.add(numtime(dates.substring(0,10).split('-')));
      }
      else{
        new_date.add([]);
      }
    }

  }else{
    for(String dates in list){
      if(dates.isNotEmpty){
      new_date.add(numtime(dates.split('/').reversed.toList()));
      }
      else{
        new_date.add([]);
      }

    }
  }

  return new_date;

}


List Format_time(List list){
  String input_file=input_info['Name'];
  String ext=input_file.split('.').last;
  List rr=[];

  if(ext=='xlsx'){
    for(var x in list){
      rr.add(numbertime2(x.split(':')));
    }
  }else{
    for(String cc in list){
      List on=cc.split(':');
      if(on.last.toString().contains('PM')){
        if(int.parse(on.first)!=12){
          rr.add(numbertime2([(int.parse(on.first)+12).toString(),on[1]]));
        }else{
          rr.add(numbertime2(['00',on[1]]));
        }
      }
      else{
        rr.add(numbertime2(on));
      }
    }
  }

  return rr;

}