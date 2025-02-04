import 'package:aqua/Custom_widget.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/variables.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'DashBoard/DashBoardPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    if(!imported){
      return Center(child: Customtext('No file has been imported', Colors.black),);
    }else{
      return const SingleChildScrollView(
          child: DashBoardPage());
    }
  }
}





