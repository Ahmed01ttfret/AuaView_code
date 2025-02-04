



import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

import '../Boxplot.dart';

// Gaussian Kernel Function
double gaussianKernel(double u) {
  return (1 / sqrt(2 * pi)) * exp(-0.5 * u * u);
}

// KDE Computation Function
List<FlSpot> computeKDE(List<double> data, double bandwidth, double minX, double maxX, double step) {

  List<FlSpot> kdePoints = [];

  for (double x = minX; x <= maxX; x += step) {
    double sum = 0;
    for (double xi in data) {
      double u = (x - xi) / bandwidth;
      sum += gaussianKernel(u);
    }
    double density = sum / (data.length * bandwidth);
    kdePoints.add(FlSpot(x, density));
  }

  return kdePoints;
}