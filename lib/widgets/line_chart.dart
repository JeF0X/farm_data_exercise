import 'package:charts_flutter/flutter.dart' as charts;
import 'package:farm_data_exercise/models/time_series_values.dart';
import 'package:flutter/material.dart';

class LineChart extends StatefulWidget {
  final List<List<TimeSeriesValues>> data;
  final bool animate;

  final String textStart;
  final String textTop;
  final String textEnd;
  final double maxHeight;

  const LineChart({
    Key? key,
    this.animate = false,
    required this.data,
    this.textStart = '',
    this.textTop = '',
    this.textEnd = '',
    this.maxHeight = 300.0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  DateTime? _time;
  Map<String, num> _measures = {};
  List<charts.Series<TimeSeriesValues, DateTime>> seriesList = [];

  @override
  void initState() {
    super.initState();
    seriesList = _createSeriesList(widget.data);
  }

  static List<charts.Series<TimeSeriesValues, DateTime>> _createSeriesList(
      List<List<TimeSeriesValues>> data) {
    List<charts.Series<TimeSeriesValues, DateTime>> seriesList = [];
    int index = 0;
    for (var item in data) {
      seriesList.add(
        charts.Series<TimeSeriesValues, DateTime>(
          id: index.toString(),
          domainFn: (TimeSeriesValues sales, _) => sales.time,
          measureFn: (TimeSeriesValues sales, _) => sales.value,
          data: item,
        ),
      );
      index++;
    }
    return seriesList;
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Expanded(
        child: charts.TimeSeriesChart(
          seriesList,
          animate: widget.animate,
          primaryMeasureAxis: const charts.NumericAxisSpec(
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(zeroBound: false)),
          behaviors: [
            charts.ChartTitle(widget.textTop,
                behaviorPosition: charts.BehaviorPosition.top,
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea),
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
      ),
    ];

    children.add(Text(_time != null ? '${_time!.month}/${_time!.year}' : ''));
    if (_measures.isEmpty) {
      children.add(const Text(''));
    }
    _measures.forEach((String series, num value) {
      children.add(Text(
        value.toStringAsFixed(1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
    });

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      child: Column(
        children: children,
      ),
    );
  }
}
