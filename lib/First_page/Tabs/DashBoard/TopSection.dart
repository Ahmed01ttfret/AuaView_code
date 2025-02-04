
import 'package:aqua/Custom_widget.dart';
import 'package:aqua/stats/Descriptive.dart';
import 'package:aqua/variables.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';


class Topsection extends StatefulWidget {
  const Topsection({Key? key}) : super(key: key);

  @override
  State<Topsection> createState() => _TopsectionState();
}

class _TopsectionState extends State<Topsection> {
  @override
  Widget build(BuildContext context) {

    return const Row(

      children: [

        Flexible(
          flex:6,

            child: AllTable()),
        Flexible(
        flex: 4,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: MissingValue(),
        ))
      ],
    );
  }
}



class AllTable extends StatefulWidget {
  const AllTable({Key? key}) : super(key: key);

  @override
  State<AllTable> createState() => _AllTableState();
}

class _AllTableState extends State<AllTable> {
  final ScrollController _horizontalScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    List<DataColumn> Header=[];
    List<DataRow> rows=[];
    for(var x in val[0]){
      Header.add(
        DataColumn(label: Customtext('$x', Colors.black))

      );
    }

    int coltrol=0;
    for(var x in val) {
      List<DataCell> gg = [];
      if (coltrol > 0) {
        for (var i in x) {
          gg.add(DataCell(Customtext('$i', Colors.black)));
        }

        rows.add(DataRow(cells: gg));
      }
      coltrol++;
    }
    return mycontainer(Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          controller: _horizontalScrollController,
          child: SingleChildScrollView(
            controller: _horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,

              child: DataTable(
                headingRowColor: WidgetStateProperty.resolveWith(
                      (states) => Colors.blueGrey[100], // Header background color
                ),



                dataRowColor: WidgetStateProperty.resolveWith(
                        (states) => Colors.grey[50]),
                columnSpacing: 16,
                horizontalMargin: 16,
                columns: Header,
                rows: rows,
                border: TableBorder.all(
                    color: Colors.blue,
                    width: 2
                ),


              ),
            ),
          ),
        ),
      ),), height*0.6);
  }
}

   



class MissingValue extends StatefulWidget {
  const MissingValue({Key? key}) : super(key: key);

  @override
  State<MissingValue> createState() => _MissingValueState();
}

class _MissingValueState extends State<MissingValue> {
  @override
  Widget build(BuildContext context) {
    Map data=Null_list(parameters);
    List<BarChartGroupData> points=[];
    int count=0;
    Map cont={};

    for(var x in data.keys){
      cont[count]='$x';

      points.add(
        BarChartGroupData(
          x: count,
          barRods: [
           BarChartRodData(toY: data[x].toDouble(), color: Colors.blue),
          ],
        ),
      );
      count++;
    }

    return mycontainer(Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10, right: 10),
      child: Center(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceEvenly,
              maxY: 100,
              barGroups: points,

              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  axisNameWidget: Customtext("Percentage of Missing Data", Colors.black),
                  sideTitles: SideTitles(
                    reservedSize: 44,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toInt()}%', // Customize Y-axis labels
                        style: TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameWidget: Customtext("Parameters", Colors.black),
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      var labels = cont; // Map x-values to string labels
                      return Transform.rotate(
                        angle: -45 * 3.141592653589793 / 180,
                        child: Text(
                          labels[value.toInt()] ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                    reservedSize: 32,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false
                  )
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false
                  )
                )
              ),
            ),
          )),
    ),


        height*0.6);
  }
}



Map Null_list(Map x){
  Map out={};
  List r=x.keys.toList();
  int len=Descriptive_Statistics().count(x[r[0]]);
  for(var i in r){

    if(Descriptive_Statistics().Number_of_null(x[i])==0){
      out[remove_unit(i.toString())]=0.02;
    }else{
      double hmm=(Descriptive_Statistics().Number_of_null(x[i])/len)*100;
      out[remove_unit(i.toString())]=hmm;
    }
  }
  return out;
}


class List_v extends StatefulWidget {
  const List_v({Key? key}) : super(key: key);

  @override
  State<List_v> createState() => _List_vState();
}

class _List_vState extends State<List_v> {
  @override
  Widget build(BuildContext context) {
    List<Widget>j=[];
    int y=0;
    while(y<=100){
      j.add(Text('$y'));
      y++;
    }
    return mycontainer(
      ListView(
        children:j,
        scrollDirection: Axis.horizontal
      ), height*0.6
    );
  }
}
