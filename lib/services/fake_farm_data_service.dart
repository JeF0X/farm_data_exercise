import 'dart:developer';

import 'package:farm_data_exercise/models/aggregated_sensor_data.dart';
import 'package:farm_data_exercise/models/farm.dart';
import 'package:farm_data_exercise/models/sensor_data.dart';
import 'package:farm_data_exercise/services/fake_data/fake_farm_data.dart';
import 'package:farm_data_exercise/services/farm_data_service.dart';

class FakeFarmDataService extends FarmDataService {
  FakeFarmDataService._();
  static final instance = FakeFarmDataService._();
  @override
  Future<List<Farm>> getFarms() async {
    try {
      var data = FakeData.getFarms();
      if (data is List<dynamic>) {
        List<Farm> farms = [];
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            farms.add(Farm.fromJson(item));
          }
        }
        return farms;
      } else {
        log(data.runtimeType.toString());
        throw Exception('Json data was not properly formatted');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Farm> getFarmInfo(String farmId) async {
    try {
      var data = FakeData.getFarmInfo(farmId);
      if (data is Map<String, dynamic>) {
        Farm farm = Farm.fromJson(data);
        return farm;
      } else {
        log(data.runtimeType.toString());
        throw Exception('Json data was not properly formatted');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SensorData>> getFarmStats(String farmId) async {
    try {
      var data = FakeData.getStats(farmId);
      if (data is! Map<String, dynamic>) {
        throw Exception('Json data was not properly formatted');
      }
      if (data['measurements'] is! List<dynamic>) {
        throw Exception('Json data was not properly formatted');
      }

      List<SensorData> stats = [];
      for (var item in data['measurements']) {
        stats.add(SensorData.fromJson(item));
      }
      return stats;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<AggregatedSensorData> getFarmStatsMonthly(
      String farmId, String sensorType) async {
    try {
      var data = FakeData.getMonthlyStats(farmId, sensorType);
      if (data is! Map<String, dynamic>) {
        throw Exception('Json data was not properly formatted');
      }
      var stats = AggregatedSensorData.fromJson(data);

      return stats;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
