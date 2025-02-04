


import 'package:aqua/stats/Descriptive.dart';
import 'package:excel/excel.dart';

List normalized(List<double> list ,double size){
  List returned=[];
  double max=Descriptive_Statistics().max(list);
  double min=Descriptive_Statistics().min(list);
  for(double x in list){
    returned.add(
        (x-min)/(max-min)*size
    );
  }




  return returned;

}




double unnormalized(List list ,double size, double x){

  double max=Descriptive_Statistics().max(list);
  double min=Descriptive_Statistics().min(list);

  return (x+min)*(max-min)/size;







}





List<double> working(List li){
  Map q=Descriptive_Statistics().quatile(li);
  return [Descriptive_Statistics().min(li),q['q1'],q['q2'],q['q3'],Descriptive_Statistics().max(li)];
}