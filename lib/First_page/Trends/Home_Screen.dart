

import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/TrendsBody.dart';
import 'package:aqua/variables.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {


    if(imported){
      return const SingleChildScrollView(child: Trendsbody());
    }
    return Center(child: Customtext('No file has been imported', Colors.black));
  }
}