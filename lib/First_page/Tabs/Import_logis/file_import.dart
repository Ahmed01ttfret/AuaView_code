

import 'dart:convert';
import 'dart:io';

import 'package:aqua/errors.dart';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';


Future<List?> Process_file(String inpu_file, File file) async {

  String fileExtension = inpu_file.split('.').last;
  print(fileExtension);
  if(fileExtension=='csv'){

    final input = file.openRead();
    try {
      final fields = await input
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList();

      return fields;
    }catch(e){
      return er();
    }

  }else{


    try {

      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      var firstSheet = excel.tables[excel.tables.keys.first];

      List<List<dynamic>> allRows = [];

      if (firstSheet != null) {
        for (var row in firstSheet.rows) {


          List<dynamic> rowData = row.map((cell) => cell?.value).toList();
          allRows.add(rowData);

        }
        allRows.toList();


      return allRows;

      }

    }catch(e){
      er();
    }


  }

}