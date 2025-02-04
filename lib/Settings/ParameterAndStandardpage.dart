

import 'package:aqua/Custom_widget.dart';
import 'package:aqua/SQL_imp.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart'as ff;
import 'package:flutter/services.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:simple_toast_message/simple_toast.dart';

import '../variables.dart';





final TextEditingController parameterName=TextEditingController();
final TextEditingController unit=TextEditingController();
final TextEditingController ideal=TextEditingController();
final TextEditingController std=TextEditingController();
final TextEditingController weight=TextEditingController();






class Parameterandstandardpage extends StatefulWidget {
  const Parameterandstandardpage({Key? key}) : super(key: key);

  @override
  State<Parameterandstandardpage> createState() => _ParameterandstandardpageState();
}

class _ParameterandstandardpageState extends State<Parameterandstandardpage> {
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      header: Container(
        color: Colors.blue,
        child: PageHeader(

          title: Customtext('Parameters And Standards', Colors.white),
          leading: IconButton(icon: const Icon(FluentIcons.back,size: 30,color: Colors.white,), onPressed: (){
            Navigator.pop(context);
          }),
          commandBar: IconButton(icon: const Icon(FluentIcons.add,
          color: Colors.white,
          size: 30,), onPressed: (){
            showDialog(context: context, builder: (context){
              return ContentDialog(
                title: Customtext('Add Standard', Colors.black),
                content: ff.Material(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Customtext('Enter Standard Name', Colors.black),
                      TextBox(
                        controller: controller,

                      )
                    ],
                  ),
                ),
                actions: [
                  HoverOutlineButton(text: 'Cancel', onPressed: (){
                    Navigator.pop(context);
                  }),
                  HoverOutlineButton(text: 'Proceed', onPressed: ()async{
                    if(controller.text.isNotEmpty){
                    addTable(await initializeDatabase(), controller.text, '''
                   
                    
                    CREATE TABLE "${controller.text}" (
	"parameter"	TEXT NOT NULL UNIQUE,
	"Unit"	TEXT,
	"Ideal"	INTEGER NOT NULL,
	"Standard"	INTEGER NOT NULL,
	"Weight"	INTEGER NOT NULL
);
                    
                   
                    ''');
                    Navigator.pop(context);
                    controller.text='';
                    tab.value=[];
                    getting();
                    SimpleToast.showSuccessToast(context, 'Created', 'Standard Successfully created');
                    }
                    else{
                      SimpleToast.showErrorToast(context, 'Error', 'Provide Standard Name');
                    }
                  })
                ],
              );
            });
          }),
        ),
      ),
      content: Container(
        color: Colors.white,
        child: const ColumnPage(),
      ),

    );
  }
}


class ColumnPage extends StatefulWidget {
  const ColumnPage({Key? key}) : super(key: key);

  @override
  State<ColumnPage> createState() => _ColumnPageState();
}

class _ColumnPageState extends State<ColumnPage> {
  @override
  Widget build(BuildContext context) {
    tab.value=[];
    getting();
    return const Column(
      children: [
        Tabs(),
        Expanded(child: ShowTable(),),
        Bottom()
      ],
    );
  }
}


class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {


    return ValueListenableBuilder(valueListenable: tab, builder: (BuildContext context ,value,_){
      List<Widget> children=[];
      int counter=0;
      int f=1;
      for(var table in value){
        children.add(
            GestureDetector(child: TabButton(counter, '$table'),
            onSecondaryTap: (){

              final entries = <ContextMenuEntry>[

                MenuItem(
                  label: 'Delete Table',
                  icon: ff.Icons.delete,
                  onSelected: () {
                   showDialog(context: context, builder: (context){
                     return ContentDialog(
                       title: Customtext('Delete Table', Colors.black),
                       content: Customtext('Are You Sure You Want To Delete Table?', Colors.red),
                       actions: [
                         HoverOutlineButton(text: 'Cancel', onPressed: (){
                           Navigator.pop(context);
                         }),
                         HoverOutlineButton(text: 'Delete', onPressed: ()async{
                           if('$table'!='Parameters') {
                             deleteTable(await initializeDatabase(), '$table');
                             tab.value.remove(table);
                             SimpleToast.showSuccessToast(context, 'Deleted',
                                 'Table Successfully Deleted');
                             getting();

                             Navigator.pop(context);
                           }
                           else{
                             SimpleToast.showErrorToast(context, 'Error', '$table cannot be deleted');
                           }
                         })
                       ],
                     );
                   });

                  },
                ),

                const MenuDivider(),

              ];


              final menu = ContextMenu(
                entries: entries,
                position: const Offset(300, 300),
                padding: const EdgeInsets.all(8.0),
              );


              showContextMenu(context, contextMenu: menu);

            },),);
        tabs.value.add(
          f
        );
        counter++;
        f=0;
      }
      return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
          )
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      );
    });
  }
}


void getting()async{
  tab.value=[];
  tab.value=await getAllTables(await initializeDatabase());
}





class ShowTable extends StatefulWidget {
  const ShowTable({Key? key}) : super(key: key);

  @override
  State<ShowTable> createState() => _ShowTableState();
}

class _ShowTableState extends State<ShowTable> {
  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder(valueListenable: tabnumber, builder: (BuildContext context,value,_) {


      return FutureBuilder<List>(
        future: getrows(value),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Padding(
              padding: EdgeInsets.only(top: 100,bottom: 100),
              child: SizedBox(

                width: 300,

                child: ff.CircularProgressIndicator.adaptive(
                  strokeWidth: 6,
                ),
              ),
            );
          }else if(snapshot.hasError){
            return Center(child: Customtext('Something Went Wrong', Colors.red),);
          }else{
// define your context menu entries


            List<ff.DataRow> rows=[];
            
            for(var x in snapshot.data!){
              rows.add(
                ff.DataRow(cells: [
                  ff.DataCell(Customtext(x['parameter'], Colors.black)),
                  ff.DataCell(Customtext(x['Unit'], Colors.black)),
                  ff.DataCell(Customtext('${x['Ideal']}', Colors.black)),
                  ff.DataCell(Customtext('${x['Standard']}', Colors.black)),

                  ff.DataCell(Customtext('${x['Weight']}', Colors.black)),
                  ff.DataCell(ff.TextButton(child: const Text('...'),onPressed: (){


                    final entries = <ContextMenuEntry>[

                      MenuItem(
                        label: 'Edith',
                        icon: ff.Icons.add,
                        onSelected: () {
                          btt.value=1;
                          parameterName.text=x['parameter'];
                          unit.text=x['Unit'];
                          ideal.text='${x['Ideal']}';
                          std.text='${x['Standard']}';
                          weight.text='${x['Weight']}';

                        },
                      ),
                      MenuItem(
                        label: 'Delete',
                        icon: ff.Icons.delete_forever,
                        onSelected: () {
                          showDialog(context: context, builder: (context){
                            return ContentDialog(
                              title: Customtext('Delete', Colors.black),
                              content: Customtext('Are Sure You Want To Delete This Item?', Colors.black),
                              actions: [
                                HoverOutlineButton(text: 'Cancel', onPressed: (){
                                  Navigator.pop(context);
                                }),
                                HoverOutlineButton(text: 'Delete', onPressed: ()async{
                                  deleteEntry(await initializeDatabase(), tab.value[tabnumber.value], x['parameter']);
                                  Navigator.pop(context);
                                  SimpleToast.showSuccessToast(context, 'Deleted', 'Item deleted Successfully. refresh to see changes');
                                })
                              ],
                            );
                          });
                        },
                      ),
                      const MenuDivider(),

                    ];


                    final menu = ContextMenu(
                      entries: entries,
                      position: const Offset(300, 300),
                      padding: const EdgeInsets.all(8.0),
                    );


                    showContextMenu(context, contextMenu: menu);
                  },)),
                ])
              );
            }
              return ff.SingleChildScrollView(
                child: ff.DataTable(
                  border: TableBorder.all(
                    color: const Color.fromARGB(25, 0, 0, 100),
                    width: 2
                  ),

                  headingRowColor: WidgetStateProperty.resolveWith(
                        (states) => ff.Colors.blueGrey[100], // Header background color
                  ),
                  columns: [
                    ff.DataColumn(label: Customtext('Parameter', Colors.black)),
                    ff.DataColumn(label: Customtext('Unit', Colors.black)),
                    ff.DataColumn(label: Customtext('Ideal', Colors.black)),
                    ff.DataColumn(label: Customtext('Standard', Colors.black)),
                    ff.DataColumn(label: Customtext('Weight', Colors.black)),
                    ff.DataColumn(label: Customtext('', Colors.black)),

                  ],
                  rows: rows,
                ),
              );


          }
        },

      );
    });
  }
}




Future<List<dynamic>> getrows(int id) async {
  if(tabnumber.value==0){
    List<Map<String, dynamic>> result = await getAllItems(await initializeDatabase(), 'Parameters');
    return result;
  }else{
  List<Map<String, dynamic>> result = await getAllItems(await initializeDatabase(), tab.value[id]);
  return result;
  }
}


class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,


      color:const Color.fromARGB(100, 0, 0, 255),
      child: ValueListenableBuilder(valueListenable: btt, builder: (context,value,_){
        if(value==0){

          return Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Adjusts alignment as needed
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns widgets vertically
              children: [
                // Parameter TextBox

                const SizedBox(width: 10),
                Expanded(
                  child: TextBox(
                    controller: parameterName,
                    placeholder: 'Parameter',
                    prefix: const Icon(FluentIcons.test_beaker),
                  ),
                ),
                const SizedBox(width: 10), // Space between TextBoxes

                // Unit TextBox
                Expanded(
                  child: TextBox(
                    controller: unit,
                    placeholder: 'Unit',
                    prefix: const Icon(FluentIcons.business_rule),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextBox(
                    keyboardType: TextInputType.number,
                    controller: ideal,
                    placeholder: 'Ideal',

                    prefix: const Icon(FluentIcons.bookings_logo),
                  ),
                ),
                const SizedBox(width: 10),
                // Standard TextBox
                Expanded(
                  child: TextBox(
                    keyboardType: TextInputType.number,
                    controller: std,
                    placeholder: 'Standard',
                    prefix: const Icon(FluentIcons.bookings_logo),
                  ),
                ),


                const SizedBox(width: 10),

                // Weight TextBox
                Expanded(
                  child: TextBox(
                    controller: weight,
                    keyboardType: TextInputType.number,
                    placeholder: 'Weight',
                    prefix: const Icon(FluentIcons.lamp),
                  ),
                ),
                const SizedBox(width: 10),

                // Add Button
                Expanded(
                  child: HoverOutlineButton(
                    onPressed: () async{
                      // Add action here
                      if(parameterName.text.isNotEmpty && weight.text.isNotEmpty && std.text.isNotEmpty && ideal.text.isNotEmpty && unit.text.isNotEmpty){
                        try {
                          addParameter(
                              await initializeDatabase(),
                              tab.value[tabnumber.value],
                              parameterName.text,
                              unit.text,
                              int.parse(ideal.text),
                              int.parse(std.text),
                              int.parse(weight.text));
                          parameterName.text='';
                          SimpleToast.showSuccessToast(context, 'Update Done', 'update successfully done, Refresh to reflect');
                        }catch(e){
                          SimpleToast.showErrorToast(context,
                              'Something Went Wrong',
                              'Ideal, Standard and weight are all suppose to be numbers');
                        }
                      }else{
                        SimpleToast.showErrorToast(context, 'Error', 'Provide all the needed data');
                      }
                    },
                    text: 'Add',
                  ),
                ),

                const SizedBox(width: 10),
              ],
            ),
          );

        }








        else{
            String paraname=parameterName.text;
          return Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Adjusts alignment as needed
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns widgets vertically
              children: [
                // Parameter TextBox

                const SizedBox(width: 10),
                Expanded(
                  child: TextBox(
                    controller: parameterName,
                    placeholder: 'Parameter',
                    prefix: const Icon(FluentIcons.test_beaker),
                  ),
                ),
                const SizedBox(width: 10), // Space between TextBoxes

                // Unit TextBox
                Expanded(
                  child: TextBox(
                    controller: unit,
                    placeholder: 'Unit',
                    prefix: const Icon(FluentIcons.business_rule),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextBox(
                    keyboardType: TextInputType.number,
                    controller: ideal,
                    placeholder: 'Ideal',

                    prefix: const Icon(FluentIcons.bookings_logo),
                  ),
                ),
                const SizedBox(width: 10),
                // Standard TextBox
                Expanded(
                  child: TextBox(
                    keyboardType: TextInputType.number,
                    controller: std,
                    placeholder: 'Standard',
                    prefix: const Icon(FluentIcons.bookings_logo),
                  ),
                ),


                const SizedBox(width: 10),

                // Weight TextBox
                Expanded(
                  child: TextBox(
                    controller: weight,
                    keyboardType: TextInputType.number,
                    placeholder: 'Weight',
                    prefix: const Icon(FluentIcons.lamp),
                  ),
                ),
                const SizedBox(width: 10),

                // Add Button
                Expanded(
                  child: HoverOutlineButton(
                    onPressed: () async{
                      // Add action here
                      if(parameterName.text.isNotEmpty && weight.text.isNotEmpty && std.text.isNotEmpty && ideal.text.isNotEmpty && unit.text.isNotEmpty){
                        try {


                          btt.value=0;
                          updateEntry(await initializeDatabase(),
                              tab.value[tabnumber.value],
                              paraname,
                              {
                                'Unit':unit.text,
                                'Ideal':ideal.text,
                                'Weight':weight.text,
                                'Standard':std.text
                              }
                          );
                          parameterName.text='';
                          SimpleToast.showSuccessToast(context, 'Update Done', 'update successfully done, Refresh to reflect');
                        }catch(e){
                          SimpleToast.showErrorToast(context,
                              'Something Went Wrong',
                              'Ideal, Standard and weight are all suppose to be numbers');
                        }
                      }else{
                        SimpleToast.showErrorToast(context, 'Error', 'Provide all the needed data');
                      }

                    },
                    text: 'update',
                  ),
                ),

                const SizedBox(width: 10),
              ],
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}

