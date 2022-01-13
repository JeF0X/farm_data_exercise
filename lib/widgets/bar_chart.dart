/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:farm_data_exercise/models/time_series_values.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<TimeSeriesValues> data;
  final bool animate;
  final double maxHeight;

  const BarChart(
      {Key? key,
      required this.data,
      this.animate = false,
      this.maxHeight = 300.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: charts.TimeSeriesChart(
        _createSeriesList(data),
        animate: animate,
        defaultRenderer: charts.BarRendererConfig<DateTime>(),
        defaultInteractions: false,
        behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
      ),
    );
  }

  static List<charts.Series<TimeSeriesValues, DateTime>> _createSeriesList(
      List<TimeSeriesValues> data) {
    return [
      charts.Series<TimeSeriesValues, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesValues sales, _) => sales.time,
        measureFn: (TimeSeriesValues sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}
