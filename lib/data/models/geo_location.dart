// lib/data/models/geo_location.dart
class GeoLocation {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String? state;

  GeoLocation({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] as String,
      state: json['state'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }

  @override
  String toString() {
    if (state != null) {
      return '$name, $state, $country';
    }
    return '$name, $country';
  }
}