import 'dart:developer';

class Farm {
  final String id;
  final String name;
  final String locationName;
  final DateTime? established;

  const Farm({
    required this.id,
    required this.name,
    required this.locationName,
    this.established,
  });

  Farm copyWith(String? id, String? name, String? locationName) => Farm(
        id: id ?? this.id,
        name: name ?? this.name,
        locationName: locationName ?? this.locationName,
      );

  @override
  String toString() {
    return '\n id: $id \n name: $name \n location: $locationName \n established: $established\n';
  }

  factory Farm.fromJson(Map<String, dynamic> jsonData) {
    String establishedString = jsonData['dateTime'] as String? ?? '';
    DateTime? established;

    // TODO: Handle exceptions
    if (establishedString.isNotEmpty) {
      try {
        established = DateTime.parse(establishedString);
      } on FormatException {
        log('Error formatting json');
        established = null;
      }
    }

    return Farm(
      id: jsonData['farm_id'] as String? ?? '',
      name: jsonData['name'] as String? ?? '',
      locationName: jsonData['location'] as String? ?? '',
      established: established,
    );
  }
}
