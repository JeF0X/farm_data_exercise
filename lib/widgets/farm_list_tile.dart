import 'package:farm_data_exercise/models/farm.dart';
import 'package:flutter/material.dart';

class FarmListTile extends StatelessWidget {
  final Farm farm;
  final VoidCallback? onTap;
  const FarmListTile({Key? key, required this.farm, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ID'),
          Text(farm.id),
        ],
      ),
      title: Text(farm.name),
      subtitle: Text(farm.locationName),
      onTap: onTap,
    );
  }
}
