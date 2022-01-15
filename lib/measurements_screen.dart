import 'package:farm_data_exercise/models/sensor_data.dart';
import 'package:farm_data_exercise/models/sensor_type.dart';
import 'package:farm_data_exercise/services/farm_data_service.dart';
import 'package:flutter/material.dart';

import 'models/farm.dart';

class MeasurementsScreen extends StatelessWidget {
  final Farm farm;
  const MeasurementsScreen({Key? key, required this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FarmDataService dataService = FarmDataService();
    return Scaffold(
      body: FutureBuilder<List<SensorData>>(
        future: dataService.getFarmStats(farm.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<SensorData>> snapshot) {
          List<Widget> children = [];
          // String dropdownValue = 'One';

          if (snapshot.hasData) {
            snapshot.data!.sort((a, b) {
              if (a.dateTime.isBefore(b.dateTime)) {
                return 1;
              }
              return -1;
            });

            List<SensorData> tempValues = snapshot.data!
                .where((element) =>
                    element.sensorType.type == SensorTypes.temperature)
                .toList();
            List<SensorData> phValues = snapshot.data!
                .where((element) => element.sensorType.type == SensorTypes.ph)
                .toList();
            List<SensorData> rainfallValues = snapshot.data!
                .where((element) =>
                    element.sensorType.type == SensorTypes.rainfall)
                .toList();

            for (var item in snapshot.data!) {
              children.add(
                ListTile(
                  leading: Text(
                    '${item.value.toStringAsFixed(1)} ${item.sensorType.suffix}',
                  ),
                  title: Text(item.sensorType.title),
                  subtitle: Text(item.dateTime.toString()),
                ),
              );
            }
          }
          return ListView(
            children: children,
          );
        },
      ),
    );
  }
}
