import 'package:farm_data_exercise/models/aggregated_sensor_data.dart';
import 'package:farm_data_exercise/models/farm.dart';
import 'package:farm_data_exercise/models/time_series_values.dart';
import 'package:farm_data_exercise/services/farm_data_service.dart';
import 'package:farm_data_exercise/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class GraphsScreen extends StatelessWidget {
  final Farm farm;
  const GraphsScreen({Key? key, required this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FarmDataService dataService = FarmDataService();
    return Scaffold(
      appBar: AppBar(
        title: Text(farm.name),
      ),
      body: FutureBuilder<AggregatedSensorData>(
        future: dataService.getFarmStatsMonthly(farm.id, 'temperature'),
        builder: (BuildContext context,
            AsyncSnapshot<AggregatedSensorData> snapshot) {
          List<Widget> children = [];

          if (snapshot.hasData) {
            List<TimeSeriesValues> values = [];
            for (var item in snapshot.data!.stats) {
              values.add(
                TimeSeriesValues(
                  DateTime(item.year, item.month),
                  item.average.toDouble(),
                ),
              );
            }
            values.sort((a, b) {
              if (a.time.isBefore(b.time)) {
                return -1;
              }
              return 1;
            });
            children = [
              LineChart(
                data: [values],
                textStart: 'temperature',
              )
            ];
          }
          return Center(
            child: Column(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
