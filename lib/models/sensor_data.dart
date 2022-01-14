class SensorData {
  final DateTime dateTime;
  final String sensorType;
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
      sensorType: jsonData['sensor_type'] as String? ?? '',
      value: jsonData['value'] as num? ?? 0.0,
    );
  }
}
