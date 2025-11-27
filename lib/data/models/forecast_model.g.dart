// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    ForecastModel(
      cod: json['cod'] as String,
      message: json['message'] as int,
      cnt: json['cnt'] as int,
      list: (json['list'] as List<dynamic>)
          .map((e) => ForecastItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForecastModelToJson(ForecastModel instance) =>
    <String, dynamic>{
      'cod': instance.cod,
      'message': instance.message,
      'cnt': instance.cnt,
      'list': instance.list.map((e) => e.toJson()).toList(),
      'city': instance.city.toJson(),
    };

ForecastItem _$ForecastItemFromJson(Map<String, dynamic> json) => ForecastItem(
  dt: json['dt'] as int,
  main: Main.fromJson(json['main'] as Map<String, dynamic>),
  weather: (json['weather'] as List<dynamic>)
      .map((e) => Weather.fromJson(e as Map<String, dynamic>))
      .toList(),
  clouds: Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
  wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),
  visibility: json['visibility'] as int,
  pop: (json['pop'] as num).toDouble(),
  rain: json['rain'] == null
      ? null
      : Rain.fromJson(json['rain'] as Map<String, dynamic>),
  sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
  dtTxt: json['dt_txt'] as String,
);

Map<String, dynamic> _$ForecastItemToJson(ForecastItem instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main.toJson(),
      'weather': instance.weather.map((e) => e.toJson()).toList(),
      'clouds': instance.clouds.toJson(),
      'wind': instance.wind.toJson(),
      'visibility': instance.visibility,
      'pop': instance.pop,
      'rain': instance.rain?.toJson(),
      'sys': instance.sys.toJson(),
      'dt_txt': instance.dtTxt,
    };

City _$CityFromJson(Map<String, dynamic> json) => City(
  id: json['id'] as int,
  name: json['name'] as String,
  coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
  country: json['country'] as String,
  population: json['population'] as int,
  timezone: json['timezone'] as int,
  sunrise: json['sunrise'] as int,
  sunset: json['sunset'] as int,
);

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'coord': instance.coord.toJson(),
  'country': instance.country,
  'population': instance.population,
  'timezone': instance.timezone,
  'sunrise': instance.sunrise,
  'sunset': instance.sunset,
};
