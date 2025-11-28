// lib/data/models/forecast_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'forecast_model.g.dart';

@JsonSerializable()
class ForecastModel {
  final String cod;
  final int message;
  final int cnt;
  final List<ForecastItem> list;
  final City city;

  ForecastModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastModelToJson(this);
}

@JsonSerializable()
class ForecastItem {
  final int dt;
  final ForecastMain main;
  final List<ForecastWeather> weather;
  final ForecastClouds clouds;
  final ForecastWind wind;
  final int visibility;
  final double pop;
  final ForecastRain? rain;
  @JsonKey(name: 'dt_txt')
  final String dtTxt;

  ForecastItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    this.rain,
    required this.dtTxt,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) =>
      _$ForecastItemFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastItemToJson(this);
}

@JsonSerializable()
class ForecastMain {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  final int pressure;
  final int humidity;
  @JsonKey(name: 'sea_level')
  final int? seaLevel;
  @JsonKey(name: 'grnd_level')
  final int? grndLevel;

  ForecastMain({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory ForecastMain.fromJson(Map<String, dynamic> json) =>
      _$ForecastMainFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastMainToJson(this);
}

@JsonSerializable()
class ForecastWeather {
  final int id;
  final String main;
  final String description;
  final String icon;

  ForecastWeather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory ForecastWeather.fromJson(Map<String, dynamic> json) =>
      _$ForecastWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastWeatherToJson(this);
}

@JsonSerializable()
class ForecastWind {
  final double speed;
  final int deg;
  final double? gust;

  ForecastWind({required this.speed, required this.deg, this.gust});

  factory ForecastWind.fromJson(Map<String, dynamic> json) =>
      _$ForecastWindFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastWindToJson(this);
}

@JsonSerializable()
class ForecastClouds {
  final int all;

  ForecastClouds({required this.all});

  factory ForecastClouds.fromJson(Map<String, dynamic> json) =>
      _$ForecastCloudsFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastCloudsToJson(this);
}

@JsonSerializable()
class ForecastRain {
  @JsonKey(name: '3h')
  final double? threeHours;

  ForecastRain({this.threeHours});

  factory ForecastRain.fromJson(Map<String, dynamic> json) =>
      _$ForecastRainFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastRainToJson(this);
}

@JsonSerializable()
class City {
  final int id;
  final String name;
  final CityCoord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class CityCoord {
  final double lat;
  final double lon;

  CityCoord({required this.lat, required this.lon});

  factory CityCoord.fromJson(Map<String, dynamic> json) =>
      _$CityCoordFromJson(json);
  Map<String, dynamic> toJson() => _$CityCoordToJson(this);
}