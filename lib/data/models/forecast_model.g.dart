// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    ForecastModel(
      cod: json['cod'] as String,
      message: (json['message'] as num).toInt(),
      cnt: (json['cnt'] as num).toInt(),
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
      'list': instance.list,
      'city': instance.city,
    };

ForecastItem _$ForecastItemFromJson(Map<String, dynamic> json) => ForecastItem(
  dt: (json['dt'] as num).toInt(),
  main: ForecastMain.fromJson(json['main'] as Map<String, dynamic>),
  weather: (json['weather'] as List<dynamic>)
      .map((e) => ForecastWeather.fromJson(e as Map<String, dynamic>))
      .toList(),
  clouds: ForecastClouds.fromJson(json['clouds'] as Map<String, dynamic>),
  wind: ForecastWind.fromJson(json['wind'] as Map<String, dynamic>),
  visibility: (json['visibility'] as num).toInt(),
  pop: (json['pop'] as num).toDouble(),
  rain: json['rain'] == null
      ? null
      : ForecastRain.fromJson(json['rain'] as Map<String, dynamic>),
  dtTxt: json['dt_txt'] as String,
);

Map<String, dynamic> _$ForecastItemToJson(ForecastItem instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main,
      'weather': instance.weather,
      'clouds': instance.clouds,
      'wind': instance.wind,
      'visibility': instance.visibility,
      'pop': instance.pop,
      'rain': instance.rain,
      'dt_txt': instance.dtTxt,
    };

ForecastMain _$ForecastMainFromJson(Map<String, dynamic> json) => ForecastMain(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  tempMin: (json['temp_min'] as num).toDouble(),
  tempMax: (json['temp_max'] as num).toDouble(),
  pressure: (json['pressure'] as num).toInt(),
  humidity: (json['humidity'] as num).toInt(),
  seaLevel: (json['sea_level'] as num?)?.toInt(),
  grndLevel: (json['grnd_level'] as num?)?.toInt(),
);

Map<String, dynamic> _$ForecastMainToJson(ForecastMain instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'sea_level': instance.seaLevel,
      'grnd_level': instance.grndLevel,
    };

ForecastWeather _$ForecastWeatherFromJson(Map<String, dynamic> json) =>
    ForecastWeather(
      id: (json['id'] as num).toInt(),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$ForecastWeatherToJson(ForecastWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

ForecastWind _$ForecastWindFromJson(Map<String, dynamic> json) => ForecastWind(
  speed: (json['speed'] as num).toDouble(),
  deg: (json['deg'] as num).toInt(),
  gust: (json['gust'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ForecastWindToJson(ForecastWind instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };

ForecastClouds _$ForecastCloudsFromJson(Map<String, dynamic> json) =>
    ForecastClouds(all: (json['all'] as num).toInt());

Map<String, dynamic> _$ForecastCloudsToJson(ForecastClouds instance) =>
    <String, dynamic>{'all': instance.all};

ForecastRain _$ForecastRainFromJson(Map<String, dynamic> json) =>
    ForecastRain(threeHours: (json['3h'] as num?)?.toDouble());

Map<String, dynamic> _$ForecastRainToJson(ForecastRain instance) =>
    <String, dynamic>{'3h': instance.threeHours};

City _$CityFromJson(Map<String, dynamic> json) => City(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  coord: CityCoord.fromJson(json['coord'] as Map<String, dynamic>),
  country: json['country'] as String,
  population: (json['population'] as num).toInt(),
  timezone: (json['timezone'] as num).toInt(),
  sunrise: (json['sunrise'] as num).toInt(),
  sunset: (json['sunset'] as num).toInt(),
);

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'coord': instance.coord,
  'country': instance.country,
  'population': instance.population,
  'timezone': instance.timezone,
  'sunrise': instance.sunrise,
  'sunset': instance.sunset,
};

CityCoord _$CityCoordFromJson(Map<String, dynamic> json) => CityCoord(
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
);

Map<String, dynamic> _$CityCoordToJson(CityCoord instance) => <String, dynamic>{
  'lat': instance.lat,
  'lon': instance.lon,
};
