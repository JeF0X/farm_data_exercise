/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:farm_data_exercise/models/time_series_values.dart';
import 'package:flutter/material.dart';

class BarChart extends StatefulWidget {
  final List<TimeSeriesValues> data;
  final bool animate;
  final double maxHeight;
  final String textStart;
  final String textEnd;

  const BarChart(
      {Key? key,
      required this.data,
      this.animate = false,
      this.maxHeight = 300.0,
      this.textStart = '',
      this.textEnd = ''})
      : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();

  static List<charts.Series<TimeSeriesValues, DateTime>> _createSeriesList(
      List<TimeSeriesValues> data) {
    return [
      charts.Series<TimeSeriesValues, DateTime>(
        id: 'Values',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesValues series, _) => series.time,
        measureFn: (TimeSeriesValues series, _) => series.value,
        labelAccessorFn: (TimeSeriesValues series, _) =>
            series.value.toString(),
        data: data,
      )
    ];
  }
}

class _BarChartState extends State<BarChart> {
  DateTime? _time;
  Map<String, num> _measures = {};
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Expanded(
        child: charts.TimeSeriesChart(
          BarChart._createSeriesList(widget.data),
          animate: widget.animate,
          defaultRenderer: charts.BarRendererConfig<DateTime>(),
          defaultInteractions: false,
          behaviors: [
            charts.SelectNearest(),
            charts.DomainHighlighter(),
            charts.ChartTitle(widget.textStart,
                behaviorPosition: charts.BehaviorPosition.start,
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea),
            charts.ChartTitle(widget.textEnd,
                behaviorPosition: charts.BehaviorPosition.end,
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea),
          ],
          selectionModels: [
            charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: _onSelectionChanged,
            )
          ],
        ),
      )
    ];

    children.add(Text(_time?.toString() ?? ''));
    if (_measures.isEmpty) {
      children.add(const Text(''));
    }
    _measures.forEach((String series, num value) {
      children.add(Text('$value'));
    });

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      child: Column(
        children: children,
      ),
    );
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime? time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      for (var datumPair in selectedDatum) {
        measures[datumPair.series.displayName!] = datumPair.datum.value;
      }
    }

    setState(() {
      _time = time;
      _measures = measures;
    });
  }
}
