// lib/data/repositories/weather_repository_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/air_quality_model.dart';
import 'package:weather_app/data/models/forecast_model.dart';
import 'package:weather_app/data/models/geo_location.dart';
import '../../core/constants/api_constants.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final http.Client client;

  WeatherRepository({http.Client? client}) : client = client ?? http.Client();

  // Get current weather by city name
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.currentWeather}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data: ${response.statusCode}');
    }
  }

  // Get current weather by coordinates
  Future<WeatherModel> getCurrentWeatherByCoords(
      double lat, double lon) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.currentWeather}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Get 5-day forecast
  Future<ForecastModel> getForecast(String cityName) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.forecast}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  // Get forecast by coordinates
  Future<ForecastModel> getForecastByCoords(double lat, double lon) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.forecast}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  // Get air quality data
  Future<AirQualityModel> getAirQuality(double lat, double lon) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.airPollution}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      return AirQualityModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load air quality data');
    }
  }

  // Search cities by name
  Future<List<GeoLocation>> searchCities(String query) async {
    final url = Uri.parse(
      '${ApiConstants.geoBaseUrl}${ApiConstants.directGeo}?q=$query&limit=5&appid=${ApiConstants.apiKey}',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => GeoLocation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search cities');
    }
  }

  // Get location name from coordinates (Reverse Geocoding)
  Future<List<GeoLocation>> reverseGeocode(double lat, double lon) async {
    final url = Uri.parse(
      '${ApiConstants.geoBaseUrl}${ApiConstants.reverseGeo}?lat=$lat&lon=$lon&limit=1&appid=${ApiConstants.apiKey}',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => GeoLocation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to reverse geocode');
    }
  }
}



