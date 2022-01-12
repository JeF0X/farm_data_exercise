import 'package:farm_data_exercise/widgets/line_chart.dart';
import 'package:farm_data_exercise/widgets/measurement_gauge.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final usData = [
  TimeSeriesValues(DateTime(2017, 9, 19), 5),
  TimeSeriesValues(DateTime(2017, 9, 26), 25),
  TimeSeriesValues(DateTime(2017, 10, 3), 78),
  TimeSeriesValues(DateTime(2017, 10, 10), 54),
];

final ukData = [
  TimeSeriesValues(DateTime(2017, 9, 19), 15),
  TimeSeriesValues(DateTime(2017, 9, 26), 33),
  TimeSeriesValues(DateTime(2017, 10, 3), 68),
  TimeSeriesValues(DateTime(2017, 10, 10), 48),
];

final fiData = [
  TimeSeriesValues(DateTime(2017, 9, 19), 12.3),
  TimeSeriesValues(DateTime(2017, 9, 26), 33.5),
  TimeSeriesValues(DateTime(2017, 10, 3), 70),
  TimeSeriesValues(DateTime(2017, 10, 10), 24.0),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: const SizedBox(
                width: 200,
                height: 200,
                child: MeasurementGauge(
                  value: 14,
                  text: 'Ph',
                  minValue: 0,
                  maxValue: 14,
                  secondSegmentStartValue: 4.5,
                  thirdSegmentStartValue: 7.0,
                ),
              ),
            ),
            LineChart(
              data: [usData, ukData, fiData],
              textStart: 'ph',
            ),
          ],
        ),
      ),
    );
  }
}
