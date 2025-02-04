

import 'package:aqua/First_page/Trends/WQI.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/variables.dart';

Future<String> sam()async{
  var list=parameters[input_info['ID']].toSet();
  String source=input_info['Source'];
  Map qw= await WQI();


  String out='''
  Here is water quality data for analysis: IDs: $list,
   Water Source: $source, and Water Quality Index (WQI) for various IDs: $qw. 
   The average values for each parameter are provided as ${Grouped_Id()}. 
   Based on this information, generate a comprehensive note on the water's quality, 
   its overall state and suitability for various uses (e.g., drinking, irrigation), 
   potential health impacts for users, and any ecological effects the water quality may 
   have on the surrounding environment, if applicable.
  ''';

  return out;
}