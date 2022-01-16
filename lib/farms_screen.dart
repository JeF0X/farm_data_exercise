import 'package:farm_data_exercise/farm_info_screen.dart';
import 'package:farm_data_exercise/models/farm.dart';
import 'package:farm_data_exercise/services/farm_data_service.dart';
import 'package:farm_data_exercise/widgets/farm_list_tile.dart';
import 'package:flutter/material.dart';

class FarmsScreen extends StatelessWidget {
  const FarmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FarmDataService dataService = FarmDataService.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farms'),
      ),
      body: FutureBuilder<List<Farm>>(
        future: dataService.getFarms(),
        builder: (BuildContext context, AsyncSnapshot<List<Farm>> snapshot) {
          List<Widget> children = [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData) {
            List<Farm> farms = snapshot.data!;
            for (var farm in farms) {
              children.add(Card(
                child: FarmListTile(
                  farm: farm,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FarmInfoScreen(
                        farm: farm,
                      ),
                    ),
                  ),
                ),
              ));
            }
          }
          return Center(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
