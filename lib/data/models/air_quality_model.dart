// lib/data/models/air_quality_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'air_quality_model.g.dart';

@JsonSerializable()
class AirQualityModel {
  final AirQualityCoord coord;
  final List<AirQualityData> list;

  AirQualityModel({required this.coord, required this.list});

  factory AirQualityModel.fromJson(Map<String, dynamic> json) =>
      _$AirQualityModelFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityModelToJson(this);
}

@JsonSerializable()
class AirQualityCoord {
  final double lat;
  final double lon;

  AirQualityCoord({required this.lat, required this.lon});

  factory AirQualityCoord.fromJson(Map<String, dynamic> json) =>
      _$AirQualityCoordFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityCoordToJson(this);
}

@JsonSerializable()
class AirQualityData {
  final int dt;
  final AirQualityMain main;
  final AirQualityComponents components;

  AirQualityData({
    required this.dt,
    required this.main,
    required this.components,
  });

  factory AirQualityData.fromJson(Map<String, dynamic> json) =>
      _$AirQualityDataFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityDataToJson(this);
}

@JsonSerializable()
class AirQualityMain {
  final int aqi;

  AirQualityMain({required this.aqi});

  factory AirQualityMain.fromJson(Map<String, dynamic> json) =>
      _$AirQualityMainFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityMainToJson(this);
}

@JsonSerializable()
class AirQualityComponents {
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final double nh3;

  AirQualityComponents({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  factory AirQualityComponents.fromJson(Map<String, dynamic> json) =>
      _$AirQualityComponentsFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityComponentsToJson(this);
}