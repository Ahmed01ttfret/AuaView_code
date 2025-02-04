

import 'package:aqua/First_page/Tabs/DashBoard/TopSection.dart';
import 'package:aqua/variables.dart';
import 'package:flutter/material.dart';

import 'DownSection.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(

        children: [
          Topsection(),
          Downsection()
        ],
      ),
    );
  }
}
