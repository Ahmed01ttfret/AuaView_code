

bool checker(Map M){
  bool R=true;
  List L=M.keys.toList();
  for(var x in L){
    for(var t in M[x]) {
      if(t!=null) {
        try {
          double.parse(t);
        } catch (y) {
          R = false;
          return false;
        }
      }
    }
  }


  return R;


}