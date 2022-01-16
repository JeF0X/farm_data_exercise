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
    FarmDataService dataService = FarmDataService.instance;
    return FutureBuilder<List<SensorData>>(
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

          var allValues = snapshot.data!;

          List<SensorData> tempValues = allValues
              .where(
                  (element) => element.sensorType.sensor == Sensor.temperature)
              .toList();
          List<SensorData> phValues = allValues
              .where((element) => element.sensorType.sensor == Sensor.ph)
              .toList();
          List<SensorData> rainfallValues = allValues
              .where((element) => element.sensorType.sensor == Sensor.rainfall)
              .toList();

          return ListView.builder(
              itemCount: allValues.length,
              itemBuilder: (context, index) {
                var item = allValues[index];
                return ListTile(
                  leading: Text(
                    '${item.value.toStringAsFixed(1)} ${item.sensorType.suffix}',
                  ),
                  title: Text(item.sensorType.title),
                  subtitle: Text(item.dateTime.toString()),
                );
              });
        }
        return const Center(
          child: SizedBox(
              width: 200.0, height: 200.0, child: CircularProgressIndicator()),
        );
      },
    );
  }
}
