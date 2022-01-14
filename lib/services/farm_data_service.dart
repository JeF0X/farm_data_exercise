import 'dart:developer';
import 'dart:io';

import 'package:farm_data_exercise/models/farm.dart';
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
}
