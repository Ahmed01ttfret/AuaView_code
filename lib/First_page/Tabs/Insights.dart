

import 'package:aqua/Custom_widget.dart';
import 'package:aqua/sumforchart.dart';
import 'package:aqua/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

final TextEditingController text=TextEditingController();
List yt=['x'];
String initial='';
List question=[];
Map ans={};



class Insight extends StatefulWidget {
  const Insight({Key? key}) : super(key: key);

  @override
  State<Insight> createState() => _InsightState();
}

class _InsightState extends State<Insight> {
  @override
  Widget build(BuildContext context) {
    return const ChartBody();
  }
}

class ChartBody extends StatefulWidget {
  const ChartBody({Key? key}) : super(key: key);

  @override
  State<ChartBody> createState() => _ChartBodyState();
}

class _ChartBodyState extends State<ChartBody> {
  @override
  Widget build(BuildContext context) {
    if(imported){
      try{

      return const Column(
        children: [
          Expanded(child: Top()),
          Bottom()
        ],
      );
      }
      catch(e){
        return Center(child: chartContainer(Customtext('Something Went Wrong \n Complete Configuration', Colors.red)));
      }
    }



    return Center(child: Customtext('No File Has Been Imported', Colors.red));
  }
}


class Top extends StatefulWidget {
  const Top({Key? key}) : super(key: key);

  @override
  State<Top> createState() => _TopState();
}

List<Content> chart=[];

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(valueListenable: gemenichat, builder: (BuildContext context,list,_){
      bool cc=true;
      List<Widget>mychild=[];

      for(var x in yt) {
        if (question.contains(x)) {
        mychild.add(Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 50,),
              chartContainer(Customtext(x, Colors.black)),
            ],
          ),
        ));
      }
        else if(!question.contains(x) && cc){
          cc=false;

          if(initial==''){
            mychild.add(
              FutureBuilder(future: sam(), builder: (context,snp){
                if(snp.hasData){
                 return FutureBuilder(future: respond(snp.data!), builder: (context,dd){
                   if(dd.hasData){
                     initial=dd.data!;

                     return Padding(
                       padding: const EdgeInsets.only(left: 10,right: 10),
                       child: chartContainer(Note(dd.data!)),
                     );
                   }else if(dd.hasError){
                     return chartContainer(Customtext('Something Went Wrong', Colors.red));
                   }
                   else{
                     return const Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,));
                   }
                 });
                }
                return const Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,));
              })
            );
          }
          else{
            mychild.add(Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: chartContainer(Note(initial)),
            ));
          }
        }

        else {
          if (ans[x]!=null) {
            mychild.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 10,top: 10,),
                child: chartContainer(Note(ans[x])),
              )
            );

          }
          else {
          mychild.add(Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: FutureBuilder(future: respond(x), builder: (context, l) {
              if (l.hasData) {
                ans[x]=l.data!;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: chartContainer(Customtext(l.data!, Colors.black)),
                );
              } else if (l.hasError) {
                return chartContainer(
                    Customtext('Something Went Wrong', Colors.red));
              }
              return const Center(child: CircularProgressIndicator(
                color: Colors.blue, strokeWidth: 2,));
            }),
          ));
        }
        }
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: mychild,
        ),
      );
    });
  }
}




final gemini = Gemini.instance;


Future<String> respond(String message) async {
  chart.add(
    Content(
      parts: [
        Part.text(message)
      ],
      role: 'user',
    ),
  );


  try {
    final response = await gemini.chat(chart);

    // Extract and return the response from the AI
    chart.add(
      Content(
        parts: [
          Part.text(response?.output ?? 'No response from the AI.')
        ],
        role: 'model',
      ),

    );
    return response?.output ?? 'No response from the AI.';
  } catch (e) {
    // Handle errors and return an appropriate message
    return 'Error**: $e \n Make Sure You Are Connected To The Internet';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              
            color: Colors.blue,
              width: 2
            )
          ),

          child: Row(
            children: [
              Expanded(child: TextField(
                controller: text,
                maxLines: 10,
                minLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Enter Message',

                ),
              )),
              IconButton(onPressed: ()async{
                if(text.text.isNotEmpty){
                  question.add(text.text);
                  yt.add(text.text);
                  gemenichat.value++;
                  yt.add('${text.text}??');

                  gemenichat.value++;

                  text.text='';
                }

              }, icon: const Icon(Icons.send,),
              color: Colors.blue)
            ],
          ),
        ),
      ),
    );
  }
}



