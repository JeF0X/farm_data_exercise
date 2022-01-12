import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GaugeSegment {
  final String segment;
  final double size;
  final charts.Color color;

  GaugeSegment(this.segment, this.size, this.color);
}

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
    double gaugeLenght = 270.0;
    var seriesList = _createSegmentData();

    var angle = (gaugeLenght * value) / getRangeLenght(minValue, maxValue) +
        (gaugeLenght * minValue.abs()) / getRangeLenght(minValue, maxValue) -
        (360 - gaugeLenght) / 2;

    return Stack(
      alignment: Alignment.center,
      children: [
        charts.PieChart<String>(
          seriesList,
          animate: animate,
          layoutConfig: charts.LayoutConfig(
            leftMarginSpec: charts.MarginSpec.fixedPixel(0),
            topMarginSpec: charts.MarginSpec.fixedPixel(0),
            rightMarginSpec: charts.MarginSpec.fixedPixel(0),
            bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
          ),
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 30,
            startAngle: 135 * pi / 180,
            arcLength: gaugeLenght * pi / 180,
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
            padding: const EdgeInsets.all(4.0),
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

  List<charts.Series<GaugeSegment, String>> _createSegmentData() {
    var rangeLenght = getRangeLenght(minValue, maxValue);

    double firstSegmentSize = secondSegmentStartValue != null
        ? secondSegmentStartValue! - minValue
        : rangeLenght;

    double secondSegmentSize =
        thirdSegmentStartValue != null && secondSegmentStartValue != null
            ? thirdSegmentStartValue! - secondSegmentStartValue!
            : rangeLenght - firstSegmentSize;

    double thirdSegmentSize =
        rangeLenght - firstSegmentSize - secondSegmentSize;

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

double getRangeLenght(double minValue, double maxValue) {
  if (minValue.isNegative) {
    return maxValue + minValue.abs();
  }
  if (maxValue.isNegative) {
    return minValue - maxValue;
  }
  return maxValue - minValue;
}
