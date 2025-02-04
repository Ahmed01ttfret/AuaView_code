import 'package:aqua/SQL_imp.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/stats/Descriptive.dart';
import 'package:aqua/variables.dart';


Map Grouped_Id(){
  '''
  Return type should be like
  {
  id1:{ph:2,Ec:66,etc..},
  id2:{pH:2,ec:88,etc},
  etc
  }
  ''';
  Map final_map={};
  List index=[];
  List All_id=parameters[input_info['ID']];
  List Id_unique=parameters[input_info['ID']];
  Id_unique=Id_unique.toSet().toList();

  for(var id in Id_unique){
    int count=0;
    List ex=[];
    for(var x in All_id){
      if(id==x){
        ex.add(count);
      }
      count++;
    }
    index.add(ex);
  }

  List data =parameters.keys.toList();


  if(input_info['ID']!=null){
    data.remove(input_info['ID']);

  }
  if(input_info['Date']!=null){
    data.remove(input_info['Date']);
  }
  int pos=0;
   for(var ss in Id_unique){
     Map inner={};
      for(var x in data){
        List param=parameters[x];
        inner[x]=Average(index[pos], param);
      }
      pos++;
      final_map[ss]=inner;
   }

  return final_map;
}




double Average(List index, List parameter){
  List values=[];
  for(int x in index){
    values.add(parameter[x]);
  }

  return Descriptive_Statistics().mean(values);
}



Future<Map> WQI()async{
  /*
  dict will be of the format {ph:1,ec:3,etc}
   */
  List keys=Grouped_Id().keys.toList();
  Map Calc_qi={};
  for(var vv in keys){

    Calc_qi[vv]=await QQ(Grouped_Id()[vv]);
  }


  return Calc_qi;


}




Future<List> modified({String tablename='Parameters'})async{
  /*
  will modify input to {
  ph:[value,weight,standard,ideal]
  }
   */
  List<String> name_parameter=[];
  final all=await getAllparameters(await initializeDatabase(), tablename);
  for(Map xx in all){
    name_parameter.add(xx['parameter']);
  }

  //print(Compare(name_parameter, 'nitry'));

  return name_parameter;
}



String Compare(List l , String text){

  if(l.contains(text)){
    return text;
  }
  else {
    int len=text.length;
    int ty=0;
    for(String t in l){

      if(t.length>=len&& text.toLowerCase()==t.toLowerCase().substring(0,len)){
        ty=1;
        return t;
      }

    }
    return '';

    }
  }


Future<double> QQ(Map M)async{

  List key=M.keys.toList();

  List<int> weights=[];
  List Wqi=[];

  for(var t in key){
    String paraname=conf[t];
    Map<String, dynamic>? dat=await getEntry(await initializeDatabase(), stdname.value, paraname);
    weights.add(dat?['Weight']);
  }

  double sum=Descriptive_Statistics().sum(weights);

  for(var x in key){


    String paraname=conf[x];

    Map<String, dynamic>? data=await getEntry(await initializeDatabase(), stdname.value, paraname);

    double top=M[x]-data?['Ideal'];
    num down=data?['Standard']-data?['Ideal'];
    num dd=(top/down)*100;
    num ee =data?['Weight']/sum;

    Wqi.add((dd*ee));

  }

  return Descriptive_Statistics().sum(Wqi);


}





Future<Map> WQA(String IdName)async{
  List new_id=[];
  List ids=parameters[input_info['ID']];
  int ct=0;
  for(var x in ids){
    if(x==IdName){
      new_id.add(ct);
    }
    ct++;
  }


  List paras=parameters.keys.toList();
  if(input_info['ID']!=null){
    paras.remove(input_info['ID']);

  }
  if(input_info['Date']!=null){
    paras.remove(input_info['Date']);
  }



  List Date=[];
  for(var t in new_id){
    Date.add(parameters[input_info['Date']][t]);
  }

  /*
  {date:{ph:1,ec:5},
  date2:{}
  }
   */

  Map output={};
  int counter=0;
  for(var rr in new_id){
    Map inner={};
    for(var y in paras){
      if(y!=null || y!=''){
      inner[y]=double.parse(parameters[y][rr]);
      }
    }
    output[Date[counter]]=inner;
    counter++;
  }


  Map vd={};

  for (String ro in output.keys){
    vd[ro]=await QQ(output[ro]);
  }

  return vd;
}


