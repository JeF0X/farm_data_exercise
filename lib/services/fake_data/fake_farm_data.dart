import 'package:farm_data_exercise/services/fake_data/farm_1_monthly.dart';
import 'package:farm_data_exercise/services/fake_data/farm_1_stats.dart';
import 'package:farm_data_exercise/services/fake_data/farm_2_monthly.dart';
import 'package:farm_data_exercise/services/fake_data/farm_2_stats.dart';

class FakeData {
  static dynamic getFarms() {
    return [
      {
        "farm_id": "1",
        "name": "Friman Metsola Collective",
        "location": "Metsola",
      },
      {
        "farm_id": "2",
        "name": "PartialTech Research Farm",
        "location": "Viikki",
      },
      // {
      //   "farm_id": "3",
      //   "name": "Noora's Farm",
      //   "location": "Tampere",
      // },
      // {
      //   "farm_id": "4",
      //   "name": "Organic Ossi's Impact That Lasts Plantation",
      //   "location": "Eteläesplanadi",
      // }
    ];
  }

  static dynamic getFarmInfo(String farmId) {
    switch (farmId) {
      case '1':
        return {
          "farm_id": "1",
          "name": "Friman Metsola Collective",
          "location": "Metsola",
          "established": "2020-10-08T00:00:00.001Z",
          "file-name": "friman_metsola.csv"
        };
      case '2':
        return {
          "farm_id": "2",
          "name": "PartialTech Research Farm",
          "location": "Viikki",
          "established": "2021-11-22T00:00:00.001Z",
          "file-name": "PartialTech.csv"
        };
      default:
        return {
          "farm_id": "2",
          "name": "PartialTech Research Farm",
          "location": "Viikki",
          "established": "2021-11-22T00:00:00.001Z",
          "file-name": "PartialTech.csv"
        };
    }
  }

  static dynamic getStats(String farmId) {
    switch (farmId) {
      case '1':
        return farm1Stats;
      case '2':
        return farm2Stats;
      default:
    }
  }

  static dynamic getMonthlyStats(String farmId, String type) {
    switch (farmId) {
      case '1':
        switch (type) {
          case 'temperature':
            return farm1TempMonthly;
          case 'ph':
            return farm1PhMonthly;
          case 'rainfall':
            return farm1RainfallMonthly;
        }
        break;
      case '2':
        switch (type) {
          case 'temperature':
            return farm2TempMonthly;
          case 'ph':
            return farm2PhMonthly;
          case 'rainfall':
            return farm2RainfallMonthly;
        }
        break;
      default:
        return farm1TempMonthly;
    }
  }
}
