

import 'package:aqua/Custom_widget.dart';
import 'package:aqua/First_page/Trends/Scatter.dart';
import 'package:aqua/variables.dart';

import 'package:flutter/material.dart';

import 'LineChart.dart';
import 'WQ_Analysis.dart';
import 'heat.dart';

class Trendsbody extends StatefulWidget {
  const Trendsbody({Key? key}) : super(key: key);

  @override
  State<Trendsbody> createState() => _TrendsbodyState();
}

class _TrendsbodyState extends State<Trendsbody> {


  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 5,child: Line(),),
              Expanded(flex: 5,child: Correlation(),)
            ],
          ),
        Row(
          children: [
            Expanded(flex: 5,child: HeatMap(),),
            Expanded(flex: 5,child: Comp(),)
          ],
        )],
      ),
    );
  }
}

class Line extends StatefulWidget {
  const Line({Key? key}) : super(key: key);

  @override
  State<Line> createState() => _LineState();
}

class _LineState extends State<Line> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: mycontainer(const Linechart(), height*0.5),
    );
  }
}



class Correlation extends StatefulWidget {
  const Correlation({Key? key}) : super(key: key);

  @override
  State<Correlation> createState() => _CorrelationState();
}

class _CorrelationState extends State<Correlation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: mycontainer(const ScatterPlot(), height*0.5),
    );
  }
}


class HeatMap extends StatefulWidget {
  const HeatMap({Key? key}) : super(key: key);

  @override
  State<HeatMap> createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMap> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: mycontainer(const Heat(), height*0.5),
    );
  }
}


class Comp extends StatefulWidget {
  const Comp({Key? key}) : super(key: key);

  @override
  State<Comp> createState() => _CompState();
}

class _CompState extends State<Comp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: mycontainer(const WqAnalysis(), height*0.5),
    );
  }
}
