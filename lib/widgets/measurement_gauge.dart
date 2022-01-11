import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MeasurementGauge extends StatelessWidget {
  final bool animate;
  final double value;
  final double minValue;
  final double maxValue;
  final String text;
  const MeasurementGauge({
    Key? key,
    required this.animate,
    required this.value,
    this.minValue = 0,
    this.maxValue = 100,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var seriesList = _createSampleData();
    var angle = (180 * value) / (minValue.abs() + maxValue.abs()) +
        (180 * minValue.abs()) / (minValue.abs() + maxValue.abs());

    return Stack(
      alignment: Alignment.center,
      children: [
        charts.PieChart<String>(
          seriesList,
          animate: animate,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 30,
            startAngle: pi,
            arcLength: pi,
            strokeWidthPx: 0.01,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(text),
          ],
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Transform.rotate(
              angle: angle * pi / 180,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_right,
                  size: 40.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      GaugeSegment('Low', maxValue.round(),
          charts.ColorUtil.fromDartColor(Colors.green)),
      // GaugeSegment(
      //     'Acceptale', 3, charts.ColorUtil.fromDartColor(Colors.green)),
      // GaugeSegment('High', 7, charts.ColorUtil.fromDartColor(Colors.red)),
    ];

    return [
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: data,
      )
    ];
  }
}

class GaugeSegment {
  final String segment;
  final int size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}
