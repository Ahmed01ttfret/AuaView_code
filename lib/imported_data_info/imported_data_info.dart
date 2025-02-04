

Map input_info={};

Map Imported_parameters(List list){
  Map retured ={};
  List top_row=list[0];
  List remaining_row=[];
  int count=0;
  for(var x in list){
    if(count!=0){
      remaining_row.add(x);
    }
    count++;
  }
  for(var parameters in top_row){
    retured[parameters]=[];
  }

  for (var uu in remaining_row){
    int c=0;
    for(var l in uu){

      retured[top_row[c]].add(l);
      c++;
    }
  }

  return retured;


}

List change_formate(List data){

  List new__=[];

  int len=data.length-1;
  int count=0;
  while(count<=len){
    List temp=[];
    List top=data[count];
    for(var x in top){
      if(x==null){
        temp.add(x);
      }else{
      temp.add(x.toString());
      }
    }
    new__.add(temp);

    count++;
  }



  return new__;
}



