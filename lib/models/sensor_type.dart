enum Sensor {
  unknown,
  temperature,
  rainfall,
  ph,
}

class SensorType {
  final Sensor sensor;
  final String suffix;
  final String abbriviation;
  final String title;

  SensorType({
    required this.sensor,
    required this.suffix,
    required this.title,
    required this.abbriviation,
  });

  factory SensorType.fromString(String sensorTypeString) {
    switch (sensorTypeString) {
      case 'temperature':
        return SensorType(
          sensor: Sensor.temperature,
          title: 'Temperature',
          suffix: 'C',
          abbriviation: 'Temp',
        );
      case 'ph':
        return SensorType(
          sensor: Sensor.ph,
          title: 'Ph',
          suffix: '',
          abbriviation: 'Ph',
        );
      case 'rainfall':
        return SensorType(
          sensor: Sensor.rainfall,
          title: 'Rainfall',
          suffix: 'mm',
          abbriviation: 'Rain',
        );
      default:
        return SensorType(
          sensor: Sensor.unknown,
          title: 'Unknown sensor type',
          suffix: 'Unknown',
          abbriviation: '',
        );
    }
  }
}
