class CityLocation {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String? country;
  final String? admin1;

  CityLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.country,
    this.admin1,
  });

  factory CityLocation.fromJson(Map<String, dynamic> json) {
    return CityLocation(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      country: json['country'],
      admin1: json['admin1'],
    );
  }

  // Add toJson method for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'admin1': admin1,
    };
  }

  // Computed property for display name
  String get displayName {
    final parts = [
      if (admin1 != null) admin1,
      if (country != null) country,
    ].where((part) => part != null && part.isNotEmpty);

    return parts.isEmpty ? name : '$name, ${parts.join(", ")}';
  }
}
