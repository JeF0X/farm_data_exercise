class SensorData {
  final DateTime dateTime;
  final String sensorType;
  final double value;

  SensorData({
    required this.dateTime,
    required this.sensorType,
    required this.value,
  });

  factory SensorData.fromJson(Map<String, dynamic> jsonData) {
    String dateTimeString = jsonData['datetime'];
    // TODO: Handle exceptions
    DateTime dateTime = DateTime.parse(dateTimeString);
    return SensorData(
      dateTime: dateTime,
      sensorType: jsonData['sensor_type'] as String? ?? '',
      value: jsonData['value'] as double? ?? 0.0,
    );
  }
}
