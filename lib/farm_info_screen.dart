import 'package:farm_data_exercise/graphs_screen.dart';
import 'package:farm_data_exercise/measurements_screen.dart';
import 'package:farm_data_exercise/models/farm.dart';
import 'package:flutter/material.dart';

class FarmInfoScreen extends StatelessWidget {
  final Farm farm;
  const FarmInfoScreen({Key? key, required this.farm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(farm.name),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.bar_chart)),
                Tab(icon: Icon(Icons.table_rows)),
              ],
            ),
          ),
          body: TabBarView(children: [
            GraphsScreen(farm: farm),
            MeasurementsScreen(farm: farm)
          ]),
        ));
  }
}
