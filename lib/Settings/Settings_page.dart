

import 'package:aqua/Custom_widget.dart';

import 'package:aqua/Settings/AboutPage.dart';
import 'package:aqua/Settings/Lineces_page.dart';
import 'package:aqua/Settings/web.dart';

import 'package:fluent_ui/fluent_ui.dart';


import 'ParameterAndStandardpage.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  @override
  Widget build(BuildContext context) {
    double halfHeight = MediaQuery.of(context).size.height * 0.5;
    double halfwidth = MediaQuery.of(context).size.width * 0.5;
    return ScaffoldPage(
      padding: EdgeInsets.zero,

      header: Container(
        color: Colors.blue,
        child: PageHeader(title: Customtext('Settings', Colors.white),

          leading: Row(
            children: [

              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: const Icon(FluentIcons.back,size: 30,color: Colors.white,)),

              const SizedBox(width: 50,),
            ],
          )
        ),
      ),
      content: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: halfwidth,
            height: halfHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),


              boxShadow: [
                BoxShadow(
                  color: Colors.blue, // Shadow color
                  blurRadius: 5.0, // Adjust blur radius
                  offset: const Offset(2.0, 4.0), // Shadow offset
                ),
              ],
            ),

            child: ListView(
              shrinkWrap: true,
              children: [

                HoverOutlineButton(text: 'Parameters And Standards', onPressed: (){
                  Navigator.push(
                    context,
                    FluentPageRoute(builder: (context) => const Parameterandstandardpage()),
                  );


                }),
                const SizedBox(height: 10,),
                HoverOutlineButton(text: 'About', onPressed: (){
                  Navigator.push(context, FluentPageRoute(builder: (context)=>const Aboutpage()));
                }),
                const SizedBox(height: 10,),
                HoverOutlineButton(text: 'Terms And License', onPressed: (){
                  Navigator.push(context, FluentPageRoute(builder: (context)=>const Linc()));
                }),
                const SizedBox(height: 10,),

                HoverOutlineButton(text: 'Documentation', onPressed: (){
                Navigator.push(context, FluentPageRoute(builder: (context)=>const Web()));


                }),

              ],
            ),
          ),
        )
      ),
    );
  }
}



