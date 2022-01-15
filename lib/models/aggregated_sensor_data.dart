import 'package:farm_data_exercise/models/sensor_type.dart';

class AggregatedSensorData {
  final SensorType sensorType;
  final List<MonthlySensorData> stats;

  AggregatedSensorData({required this.sensorType, required this.stats});

  factory AggregatedSensorData.fromJson(Map<String, dynamic> data) {
    if (data['stats'] is! List<dynamic>) {
      throw Exception('Json data was not properly formatted');
    }
    List<dynamic> statsData = data['stats'];
    List<MonthlySensorData> stats = [];

    for (var statData in statsData) {
      stats.add(MonthlySensorData.fromJson(statData));
    }

    return AggregatedSensorData(
      sensorType: SensorType.fromString(data['sensor_type'] as String? ?? ''),
      stats: stats,
    );
  }
  @override
  String toString() {
    return '\n $sensorType \n${stats.toString()} ';
  }
}

class MonthlySensorData {
  final int month;
  final int year;
  final num average;
  final num median;
  final num stantardDeviation;

  MonthlySensorData({
    required this.month,
    required this.year,
    required this.average,
    required this.median,
    required this.stantardDeviation,
  });

  factory MonthlySensorData.fromJson(Map<String, dynamic> jsonData) {
    return MonthlySensorData(
      month: jsonData['month'] as int? ?? 0,
      year: jsonData['year'] as int? ?? 0,
      average: jsonData['average'] as num? ?? 0.0,
      median: jsonData['median'] as num? ?? 0.0,
      stantardDeviation: jsonData['stantard_deviation'] as num? ?? 0.0,
    );
  }

  @override
  String toString() {
    return '\ndate: $month/$year \naverage: $average \nmedian: $median, \ndeviation: $stantardDeviation\n';
  }
}
