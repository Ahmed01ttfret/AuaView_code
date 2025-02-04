import 'dart:io';

import 'package:aqua/Custom_widget.dart';

import 'package:aqua/First_page/Tabs/Import_logis/First_table.dart';
import 'package:aqua/First_page/Tabs/Import_logis/file_import.dart';
import 'package:aqua/First_page/Tabs/Import_logis/info.dart';
import 'package:aqua/checker.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/variables.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:file_picker/file_picker.dart';
import 'package:simple_toast_message/simple_toast.dart';

class Import extends StatefulWidget {
  const Import({Key? key}) : super(key: key);

  @override
  State<Import> createState() => _ImportState();
}

class _ImportState extends State<Import> {
  @override
  Widget build(BuildContext context) {
    return const Content();
  }
}


class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(

        children: [
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Customtext('Import an Excel file with either .xlsx or .csv extension.',Colors.black),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HoverOutlineButton(text: 'ADD', onPressed: ()async{
                  Previewlist.value=[];
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['csv','xlsx'],

                 );
                  // print(result);
                 input_path=result?.files.single.path!;
                  file_name=result?.files.single.name;
                  size =result?.files.single.size;
                  input_info['Name']=file_name;



                  List new_=change_formate((await Process_file(input_path!,File(input_path!)))!);
                  List new__=change_formate((await Process_file(input_path!,File(input_path!)))!);

                  val=new_;
                  parameters=Imported_parameters(new_);
                  xcx=Imported_parameters(new__);
                  List show=new__;

                  int yy=new__[0].length-2;
                  if (new_.length<6){
                  Previewlist.value= new__;



                    int count=0;
                    for(List x in Previewlist.value){
                      x.insert(0, count);
                      count++;
                    }


                  }else{


                    List patial=show.sublist(0,4);
                     int total=show.length;

                     List cc=[];
                     int cp=2;
                     List inners=show[0];

                    int inner=inners.length;

                    while(cp<inner){
                      cc.add('--');
                      cp++;

                    }
                    patial.add(cc);
                    patial.add(cc);
                    patial.add(cc);



                    int ct=0;
                    for(List x in patial){

                      if(ct<4){
                        x.insert(0, ct);
                      }else{
                        x.add('--');
                      }
                      ct++;
                    }


                    List p=show.last;
                    p.insert(0, total);
                    patial.add(p);



                    Previewlist.value=patial;

                  }

                  drop.value=new_;
                  input_info['Number_of_Parameters']=yy;
                  info_.value=[file_name,'$size',input_path,'$yy'];

                }),
              )
            ],
          ),
          Expanded(
            child: Container(

              color: Colors.transparent,
              child: Column(
                children: [
                  Expanded(

                     child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                           Expanded(
                             child: mycontainer(const PreViewTable(),double.infinity),
                           ),
                            const SizedBox(width: 30,),
                            Expanded(child: mycontainer(const Info_For_Imported_file(),double.infinity)),
                          ],
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        Customtext("If you’re sure you've selected the correct file, press 'Continue' to proceed.", Colors.black),
                        HoverOutlineButton(text: 'Continue', onPressed: (){

                          if(input_info.isNotEmpty) {
                            if (input_info['Number_of_Parameters'] >= 2 &&
                                input_info['Source'] != null &&
                                input_info['ID'] != null) {



                              if(input_info['ID']!=null){
                                xcx.remove(input_info['ID']);


                              }
                              if(input_info['Date']!=null){
                                xcx.remove(input_info['Date']);
                              }
                              if(checker(xcx)) {
                                SimpleToast.showSuccessToast(context,
                                    "Data Import Successful",
                                    "Your data has been imported successfully.");

                                imported = true;
                              }else{
                                SimpleToast.showErrorToast(
                                    context, 'Import Error',
                                    "Ensure Correct Configuration and make sure all values for the parameters are either numeric or null");
                              }
                            } else {
                              SimpleToast.showErrorToast(
                                  context, 'Import Error',
                                  "Data should have at least 2 columns, this is because ID is require");
                            }
                          }else{
                            SimpleToast.showErrorToast(context, 'Error', 'Import a .csv or .xlsx file');
                          }
                        })
                      ],
                    ),
                  )
                ],
              ),

            ),
          )
        ],
      ),
    );
  }
}



