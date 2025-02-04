
import 'package:flutter/material.dart';


final ValueNotifier<int> pages = ValueNotifier<int>(0);

bool imported=false;

String? input_path='';
String? file_name='';
int? size;

String option='Select Date/Time column';
Map sum_stat={};
String temp='';
String option1='Select ID column';

final ValueNotifier<List>Previewlist=ValueNotifier<List>([]);
final ValueNotifier<List>drop=ValueNotifier<List>([['']]);

final ValueNotifier<List>info_=ValueNotifier(['','','','']);
final ValueNotifier<String>ids=ValueNotifier('Select ID');
final ValueNotifier<String>params=ValueNotifier('Select a Parameter');
final ValueNotifier<String>chartid=ValueNotifier('Select an ID');
final ValueNotifier<String>paramitems=ValueNotifier('Select a Parameter!');
final ValueNotifier<String>chart=ValueNotifier('Select Chart');
final ValueNotifier<List>LineList=ValueNotifier<List<List>>([]);
final ValueNotifier<int>integer=ValueNotifier<int>(0);
final ValueNotifier<String>X=ValueNotifier('Select X parameter');
final ValueNotifier<String>Y=ValueNotifier('Select Y parameter');
bool reset=true;
final ValueNotifier<bool>Buttontext=ValueNotifier(true);
final ValueNotifier<int>int2=ValueNotifier<int>(0);
final ValueNotifier<int>cht=ValueNotifier<int>(0);
final ValueNotifier<double>bandwith=ValueNotifier<double>(5.0);

String id_check='';
bool datetype=true;
Map xcx={};
Map parameters={};
List val=[];
String id='ID';
String p='P';
List<String> industrialWaterSources = [
  "Chemical Manufacturing",
  "Pharmaceuticals",
  "Oil and Gas Extraction",
  "Food and Beverage Processing",
  "Metal Finishing and Electroplating",
  "Pulp and Paper Mills",
  "Power Plants (Thermal/Hydro)",
  "Agricultural Runoff",
  "Automotive Manufacturing",
  "Battery Manufacturing",
  "Electronics and Semiconductors",
  "Construction and Demolition Sites",
  "Tanneries (Leather Processing)",
  "Paints and Coatings Production",
  "Cement and Lime Production",
  "Fertilizer Manufacturing",
  "Plastic and Polymer Production",
  "Fish and Seafood Processing",
  "Steel and Iron Production",
  "Textile Dyeing and Finishing",
  "Livestock and Poultry Farming",
  "Gold Mining"
];



double height=1.0;


String remove_unit(String text){
  if(text.contains('(')){
    int pos=text.indexOf('(');
    text=text.substring(0,pos);
    return text;
  }

  return text;
}

List Standards=[];
final ValueNotifier<List>tab=ValueNotifier<List>([]);
final ValueNotifier<List>tabs=ValueNotifier<List>([]);
final ValueNotifier<int>tabnumber=ValueNotifier<int>(0);
final ValueNotifier<int>btt=ValueNotifier<int>(0);
final ValueNotifier<int>ht=ValueNotifier<int>(0);
final ValueNotifier<String>stdname=ValueNotifier('Parameters');
Map conf={};



final ValueNotifier<int>gemenichat=ValueNotifier<int>(0);

int options=0;


