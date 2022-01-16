import 'package:farm_data_exercise/models/time_series_values.dart';

import 'package:farm_data_exercise/widgets/bar_chart.dart';
import 'package:farm_data_exercise/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class GraphsScreen extends StatelessWidget {
  final List<TimeSeriesValues> phValues;
  final List<TimeSeriesValues> rainfallValues;
  final List<TimeSeriesValues> tempValues;
  const GraphsScreen(
      {Key? key,
      required this.phValues,
      required this.rainfallValues,
      required this.tempValues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = [
      Card(
        child: LineChart(
          data: [phValues],
          textTop: 'Monthly AVG',
          textStart: 'Ph',
          maxHeight: 250.0,
        ),
      ),
      Card(
        child: BarChart(
          data: rainfallValues,
          textTop: 'Monthly AVG',
          textStart: 'Rainfall (mm)',
          maxHeight: 250.0,
        ),
      ),
      Card(
        child: LineChart(
          data: [tempValues],
          textTop: 'Monthly AVG',
          textStart: 'Temperature (°C)',
          maxHeight: 250.0,
        ),
      ),
    ];
    return ListView(
      children: children,
    );
  }
}
