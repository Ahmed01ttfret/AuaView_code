


import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Tabs/DashBoard/parameter_and_standards.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/variables.dart';
import 'package:flutter/material.dart';

import 'Destrbution_chart.dart';

class Downsection extends StatefulWidget {
  const Downsection({Key? key}) : super(key: key);

  @override
  State<Downsection> createState() => _DownsectionState();
}

class _DownsectionState extends State<Downsection> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(

        children: [
          Flexible(
            flex:1,
              child: ID_Unit()),
          Flexible(
            flex: 3,
              child: TimeLine()),
          Flexible(
            flex: 6,
              child: Destribution())
        ],
      ),
    );
  }
}



class TimeLine extends StatefulWidget {
  const TimeLine({Key? key}) : super(key: key);

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: mycontainer(ValueListenableBuilder(
        valueListenable: ht,
          builder: (context,val,_){
          if(val==0){
            return Center(child: Customtext('Something Went Wrong\n Ensure Proper Configuration', Colors.red));
          }

          return const Center(child: ParameterAndStandards());}
            ),height*0.35)



    );
  }
}



class ID_Unit extends StatefulWidget {
  const ID_Unit({Key? key}) : super(key: key);

  @override
  State<ID_Unit> createState() => _ID_UnitState();
}

class _ID_UnitState extends State<ID_Unit> {
  @override
  Widget build(BuildContext context) {

    if(input_info['ID']==null){
      return Padding(
        padding: const EdgeInsets.only(right: 10),

        child: mycontainer(
          Center(
              child: Customtext('The ID column has not been selected. '
                  'Please navigate to the Import tab and choose the ID '
                  'column from the dropdown menu.',Colors.red)
        ),height*0.35),
      );
    }else{

    var id=input_info['ID'];
    List v=parameters[id];

    List<Widget> ids=[];
    for(var x in v.toSet().toList()){
      ids.add(Customtext('$x', Colors.black));
    }

    List<Widget> para=[];
    List ff=parameters.keys.toList();
    ff.remove(input_info['ID']);
    for(var tt in ff){
      para.add(
       Customtext('$tt', Colors.black)
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: mycontainer(Center(child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            const Center(child: Text('IDs',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),)),
            const Divider(
              color: Colors.blue,
              thickness: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:ids,
                ),
              ),
            )
          ],
        ),
      )),height*0.35),
    );}
  }
}



class Destribution extends StatefulWidget {
  const Destribution({Key? key}) : super(key: key);

  @override
  State<Destribution> createState() => _DestributionState();
}

class _DestributionState extends State<Destribution> {
  @override
  Widget build(BuildContext context) {
    if(input_info['ID']==null) {
      return Center(child: Customtext('Select Id column', Colors.red));
    }

    return mycontainer(const Destrbution_chart(), height*0.35);
  }
}