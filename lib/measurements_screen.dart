import 'package:farm_data_exercise/models/sensor_data.dart';
import 'package:farm_data_exercise/models/sensor_type.dart';
import 'package:flutter/material.dart';

class MeasurementsScreen extends StatefulWidget {
  final List<SensorData> data;

  const MeasurementsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen> {
  String dropdownValue = 'All';
  List<SensorData> valuesToShow = [];

  @override
  Widget build(BuildContext context) {
    List<SensorData> allValues = _sortValuesByDate(widget.data);
    List<SensorData> tempValues =
        _filterValuesList(allValues, Sensor.temperature);
    List<SensorData> phValues = _filterValuesList(allValues, Sensor.ph);
    List<SensorData> rainfallValues =
        _filterValuesList(allValues, Sensor.rainfall);

    switch (dropdownValue) {
      case 'All':
        valuesToShow = allValues;
        break;
      case 'Rainfall':
        valuesToShow = rainfallValues;
        break;
      case 'Temperature':
        valuesToShow = tempValues;
        break;
      case 'Ph':
        valuesToShow = phValues;
        break;
      default:
    }

    return Stack(
      children: [
        ListView.builder(
            padding: const EdgeInsets.only(bottom: 50.0),
            itemCount: valuesToShow.length,
            itemBuilder: (context, index) {
              var item = valuesToShow[index];
              return Align(
                alignment: Alignment.centerRight,
                child: ListTile(
                  leading: Text(
                    '${item.value.toStringAsFixed(1)} ${item.sensorType.suffix}',
                  ),
                  title: Text(item.sensorType.title),
                  subtitle: Text(item.dateTime.toString()),
                ),
              );
            }),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.blueAccent,
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue ?? 'all';
                  });
                },
                items: <String>['All', 'Rainfall', 'Ph', 'Temperature']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<SensorData> _filterValuesList(
      List<SensorData> allValues, Sensor sensor) {
    return allValues
        .where((element) => element.sensorType.sensor == sensor)
        .toList();
  }

  List<SensorData> _sortValuesByDate(List<SensorData> values) {
    values.sort((a, b) {
      if (a.dateTime.isBefore(b.dateTime)) {
        return -1;
      }
      return 1;
    });
    return values;
  }
}
