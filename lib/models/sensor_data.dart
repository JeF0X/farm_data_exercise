import 'package:farm_data_exercise/models/sensor_type.dart';

class SensorData {
  final DateTime dateTime;
  final SensorType sensorType;
  final num value;

  SensorData({
    required this.dateTime,
    required this.sensorType,
    required this.value,
  });

  @override
  String toString() {
    return '\n $value\n $dateTime\n $sensorType\n';
  }

  factory SensorData.fromJson(Map<String, dynamic> jsonData) {
    String dateTimeString = jsonData['datetime'];
    // TODO: Handle exceptions
    DateTime dateTime = DateTime.parse(dateTimeString);
    return SensorData(
      dateTime: dateTime,
      sensorType:
          SensorType.fromString(jsonData['sensor_type'] as String? ?? ''),
      value: jsonData['value'] as num? ?? 0.0,
    );
  }
}
