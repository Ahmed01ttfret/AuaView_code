

import 'package:aqua/First_page/Tabs/Dashboard.dart';
import 'package:aqua/First_page/Tabs/Import.dart';
import 'package:aqua/First_page/Tabs/Insights.dart';
import 'package:aqua/First_page/Tabs/Summry.dart';
import 'package:aqua/First_page/Tabs/Trends.dart';
import 'package:aqua/variables.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(valueListenable: pages,
        builder: (context,value,child){
      if(value==0){
        return const Dashboard();
      }else if(value==1){
        return const Import();
      }else if(value==2){
        return const Trends();
      }else if(value==3){
        return const Insight();
      }
      return const Summery();

       });
  }
}
