class AggregatedSensorData {
  final String sensorType;
  final List<MonthlySensorData> stats;

  AggregatedSensorData({required this.sensorType, required this.stats});

  factory AggregatedSensorData.fromJson(Map<String, dynamic> data) {
    List<Map<String, dynamic>> statsData = data['stats'];
    List<MonthlySensorData> stats = [];

    for (var statData in statsData) {
      stats.add(MonthlySensorData.fromJson(statData));
    }

    return AggregatedSensorData(
      sensorType: data['sensor_type'],
      stats: stats,
    );
  }
}

class MonthlySensorData {
  final String month;
  final String year;
  final double average;
  final double median;
  final double stantardDeviation;

  MonthlySensorData({
    required this.month,
    required this.year,
    required this.average,
    required this.median,
    required this.stantardDeviation,
  });

  factory MonthlySensorData.fromJson(Map<String, dynamic> data) {
    return MonthlySensorData(
      month: data['month'] as String? ?? '',
      year: data['year'] as String? ?? '',
      average: data['average'] as double? ?? 0.0,
      median: data['median'] as double? ?? 0.0,
      stantardDeviation: data['stantard_deviation'] as double? ?? 0.0,
    );
  }
}
