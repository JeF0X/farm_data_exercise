import 'package:farm_data_exercise/graphs_screen.dart';
import 'package:farm_data_exercise/measurements_screen.dart';
import 'package:farm_data_exercise/models/aggregated_sensor_data.dart';
import 'package:farm_data_exercise/models/farm.dart';
import 'package:farm_data_exercise/models/time_series_values.dart';
import 'package:farm_data_exercise/services/farm_data_service.dart';
import 'package:flutter/material.dart';

class FarmInfoScreen extends StatelessWidget {
  final Farm farm;
  const FarmInfoScreen({Key? key, required this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FarmDataService dataService = FarmDataService.instance;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(farm.name),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.bar_chart)),
                  Tab(icon: Icon(Icons.table_rows)),
                ],
              ),
            ),
            body: FutureBuilder<List>(
              future: Future.wait([
                dataService.getFarmStats(farm.id),
                dataService.getFarmStatsMonthly(farm.id, 'ph'),
                dataService.getFarmStatsMonthly(farm.id, 'rainfall'),
                dataService.getFarmStatsMonthly(farm.id, 'temperature'),
              ]),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  List<TimeSeriesValues> phValues = [];
                  List<TimeSeriesValues> rainfallValues = [];
                  List<TimeSeriesValues> tempValues = [];
                  // ph
                  phValues = _parseValuesToTimeSeries(snapshot.data![1].stats);
                  phValues = _sortValuesByDate(phValues);
                  //rainfall
                  rainfallValues =
                      _parseValuesToTimeSeries(snapshot.data![2].stats);
                  rainfallValues = _sortValuesByDate(rainfallValues);
                  //Temp
                  tempValues =
                      _parseValuesToTimeSeries(snapshot.data![3].stats);
                  tempValues = _sortValuesByDate(tempValues);

                  return TabBarView(children: [
                    GraphsScreen(
                      phValues: phValues,
                      rainfallValues: rainfallValues,
                      tempValues: tempValues,
                    ),
                    MeasurementsScreen(
                      data: snapshot.data![0],
                    )
                  ]);
                }
                return const Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )));
  }

  List<TimeSeriesValues> _parseValuesToTimeSeries(
      List<MonthlySensorData> data) {
    List<TimeSeriesValues> values = [];
    for (var item in data) {
      values.add(
        TimeSeriesValues(
          DateTime(item.year, item.month),
          item.average.toDouble(),
        ),
      );
    }
    return values;
  }

  List<TimeSeriesValues> _sortValuesByDate(List<TimeSeriesValues> values) {
    values.sort((a, b) {
      if (a.time.isBefore(b.time)) {
        return -1;
      }
      return 1;
    });
    return values;
  }
}
