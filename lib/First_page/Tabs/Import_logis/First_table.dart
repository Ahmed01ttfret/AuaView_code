


import 'package:aqua/Custom_widget.dart';
import 'package:flutter/material.dart';


import '../../../variables.dart';

class PreViewTable extends StatefulWidget {
  const PreViewTable({Key? key}) : super(key: key);

  @override
  State<PreViewTable> createState() => _PreViewTableState();
}

class _PreViewTableState extends State<PreViewTable> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _horizontalScrollController = ScrollController();


    return ValueListenableBuilder<List>(valueListenable: Previewlist,
        builder: (BuildContext context,value,build)
    {
      if (value.isNotEmpty){


      List<DataColumn> cols=[];
      for(var x in value[0]){
        cols.add(
            DataColumn(label: Customtext('$x', Colors.black))
        );

      }
      List<DataRow> rows=[];
      int coltrol=0;
      for(var x in value) {
        List<DataCell> gg = [];
        if (coltrol > 0) {
        for (var i in x) {
          gg.add(DataCell(Customtext('$i', Colors.black)));
        }

        rows.add(DataRow(cells: gg));
      }
        coltrol++;
      }


      //
      // List parameters=value[0];
      // for(var x in parameters){
      //   print(x);
      //   Imported_parameters[x]=[];
      // }
      // // List values=value;
      // // values.removeAt(0);
      // // for(var parameter in values){
      // //   int ct=0;
      // //   for(var t in parameter){
      // //     Imported_parameters[parameters[ct]].add(t);
      // //   }
      // //   ct+=1;
      // // }


        return Padding(
          padding: const EdgeInsets.all(10),
          child: Scrollbar(

            controller: _horizontalScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
            
                  DataTable(
                    headingRowColor: WidgetStateProperty.resolveWith(
                          (states) => Colors.blueGrey[100], // Header background color
                    ),
                    dataRowColor: WidgetStateProperty.resolveWith(
                            (states) => Colors.grey[50]),
                    columnSpacing: 16,
                    horizontalMargin: 16,


                    columns: cols,
                    rows: rows,
            
                    border: TableBorder.all(
                      color: Colors.blue,
                      width: 2
                    ),
            
            

                  ),
                ],
              ),
            ),
          ),
        );
    }else{
        return const SizedBox();
      }
        });
  }
}
