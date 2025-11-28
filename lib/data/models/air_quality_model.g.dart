// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirQualityModel _$AirQualityModelFromJson(Map<String, dynamic> json) =>
    AirQualityModel(
      coord: AirQualityCoord.fromJson(json['coord'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>)
          .map((e) => AirQualityData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirQualityModelToJson(AirQualityModel instance) =>
    <String, dynamic>{'coord': instance.coord, 'list': instance.list};

AirQualityCoord _$AirQualityCoordFromJson(Map<String, dynamic> json) =>
    AirQualityCoord(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$AirQualityCoordToJson(AirQualityCoord instance) =>
    <String, dynamic>{'lat': instance.lat, 'lon': instance.lon};

AirQualityData _$AirQualityDataFromJson(Map<String, dynamic> json) =>
    AirQualityData(
      dt: (json['dt'] as num).toInt(),
      main: AirQualityMain.fromJson(json['main'] as Map<String, dynamic>),
      components: AirQualityComponents.fromJson(
        json['components'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$AirQualityDataToJson(AirQualityData instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main,
      'components': instance.components,
    };

AirQualityMain _$AirQualityMainFromJson(Map<String, dynamic> json) =>
    AirQualityMain(aqi: (json['aqi'] as num).toInt());

Map<String, dynamic> _$AirQualityMainToJson(AirQualityMain instance) =>
    <String, dynamic>{'aqi': instance.aqi};

AirQualityComponents _$AirQualityComponentsFromJson(
  Map<String, dynamic> json,
) => AirQualityComponents(
  co: (json['co'] as num).toDouble(),
  no: (json['no'] as num).toDouble(),
  no2: (json['no2'] as num).toDouble(),
  o3: (json['o3'] as num).toDouble(),
  so2: (json['so2'] as num).toDouble(),
  pm2_5: (json['pm2_5'] as num).toDouble(),
  pm10: (json['pm10'] as num).toDouble(),
  nh3: (json['nh3'] as num).toDouble(),
);

Map<String, dynamic> _$AirQualityComponentsToJson(
  AirQualityComponents instance,
) => <String, dynamic>{
  'co': instance.co,
  'no': instance.no,
  'no2': instance.no2,
  'o3': instance.o3,
  'so2': instance.so2,
  'pm2_5': instance.pm2_5,
  'pm10': instance.pm10,
  'nh3': instance.nh3,
};
