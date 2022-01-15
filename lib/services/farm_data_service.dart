import 'dart:developer';
import 'dart:io';

import 'package:farm_data_exercise/models/aggregated_sensor_data.dart';
import 'package:farm_data_exercise/models/farm.dart';
import 'package:farm_data_exercise/models/sensor_data.dart';
import 'package:farm_data_exercise/services/http_service.dart';

class FarmDataService {
  static const _apiUrl = 'http://10.0.2.2:8080/v1/';

  final HttpService httpService = HttpService();

  Future<List<Farm>> getFarms() async {
    try {
      var url = _apiUrl + 'farms';
      var data = await httpService.sendRequest(url);
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
    } on HttpException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Farm> getFarmInfo(int farmId) async {
    try {
      var url = _apiUrl + 'farms/$farmId';
      var data = await httpService.sendRequest(url);
      if (data is Map<String, dynamic>) {
        Farm farm = Farm.fromJson(data);
        return farm;
      } else {
        log(data.runtimeType.toString());
        throw Exception('Json data was not properly formatted');
      }
    } on HttpException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<SensorData>> getFarmStats(int farmId) async {
    try {
      var url = _apiUrl + 'farms/$farmId/stats';
      var data = await httpService.sendRequest(url);
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
    } on HttpException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<AggregatedSensorData> getFarmStatsMonthly(
      String farmId, String sensorType) async {
    try {
      var url = _apiUrl + 'farms/$farmId/stats/$sensorType/monthly';
      var data = await httpService.sendRequest(url);
      if (data is! Map<String, dynamic>) {
        throw Exception('Json data was not properly formatted');
      }
      var stats = AggregatedSensorData.fromJson(data);

      return stats;
    } on HttpException catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
