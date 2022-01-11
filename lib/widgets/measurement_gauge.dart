import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MeasurementGauge extends StatelessWidget {
  final bool animate;
  final double value;
  final double minValue;
  final double maxValue;
  final double? secondSegmentStartValue;
  final double? thirdSegmentStartValue;
  final String text;
  final Color firstSegmentColor;
  final Color secondSegmentColor;
  final Color thirdSegmentColor;

  const MeasurementGauge({
    Key? key,
    this.animate = false,
    required this.value,
    this.minValue = 0,
    this.maxValue = 100,
    this.text = '',
    this.secondSegmentStartValue,
    this.thirdSegmentStartValue,
    this.firstSegmentColor = Colors.red,
    this.secondSegmentColor = Colors.green,
    this.thirdSegmentColor = Colors.red,
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
    var range = getRange(minValue, maxValue);

    double firstSegmentSize = secondSegmentStartValue != null
        ? secondSegmentStartValue! - minValue
        : range;

    double secondSegmentSize =
        thirdSegmentStartValue != null && secondSegmentStartValue != null
            ? thirdSegmentStartValue! - secondSegmentStartValue!
            : range - firstSegmentSize;

    double thirdSegmentSize = range - firstSegmentSize - secondSegmentSize;

    final data = [
      GaugeSegment('First', firstSegmentSize,
          charts.ColorUtil.fromDartColor(firstSegmentColor)),
      GaugeSegment('Second', (secondSegmentSize),
          charts.ColorUtil.fromDartColor(secondSegmentColor)),
      GaugeSegment('Third', (thirdSegmentSize),
          charts.ColorUtil.fromDartColor(thirdSegmentColor)),
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

double getRange(double minValue, double maxValue) {
  if (minValue.isNegative) {
    return maxValue + minValue.abs();
  }
  if (maxValue.isNegative) {
    return minValue - maxValue;
  }
  return maxValue - minValue;
}

class GaugeSegment {
  final String segment;
  final double size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}
