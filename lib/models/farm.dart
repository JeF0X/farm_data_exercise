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

  factory Farm.fromJson(Map<String, dynamic> data) {
    String establishedString = data['dateTime'] as String? ?? '';
    DateTime? established;

    // TODO: Handle exceptions
    if (establishedString.isNotEmpty) {
      try {
        established = DateTime.parse(establishedString);
      } on FormatException {
        established = null;
      }
    }

    return Farm(
      id: data['farm_id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      locationName: data['location'] as String? ?? '',
      established: established,
    );
  }
}
