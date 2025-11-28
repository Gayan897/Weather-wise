// lib/data/repositories/weather_repository_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/air_quality_model.dart';
import '../models/geo_location.dart';

class WeatherRepository {
  final http.Client client;

  WeatherRepository({http.Client? client}) : client = client ?? http.Client();

  // Get current weather by city name
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.currentWeather}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric',
      );

      print('🌐 Fetching weather for: $cityName');
      print('📍 URL: $url');

      final response = await client
          .get(url)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Connection timeout. Please check your internet connection.',
              );
            },
          );

      print('📊 Response status: ${response.statusCode}');
      print('📦 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception(
          'Invalid API key. Please check your OpenWeatherMap API key.',
        );
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please check the city name.');
      } else {
        throw Exception(
          'Failed to load weather: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('❌ Error in getCurrentWeather: $e');
      rethrow;
    }
  }

  // Get current weather by coordinates
  Future<WeatherModel> getCurrentWeatherByCoords(double lat, double lon) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.currentWeather}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric',
      );

      print('🌐 Fetching weather for coordinates: $lat, $lon');

      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));

      print('📊 Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key');
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('❌ Error in getCurrentWeatherByCoords: $e');
      rethrow;
    }
  }

  // Get 5-day forecast
  Future<ForecastModel> getForecast(String cityName) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.forecast}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric',
      );

      print('🌐 Fetching forecast for: $cityName');

      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));

      print('📊 Forecast response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return ForecastModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key');
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      print('❌ Error in getForecast: $e');
      rethrow;
    }
  }

  // Get forecast by coordinates
  Future<ForecastModel> getForecastByCoords(double lat, double lon) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.forecast}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric',
      );

      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return ForecastModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      print('❌ Error in getForecastByCoords: $e');
      rethrow;
    }
  }

  // Get air quality data
  Future<AirQualityModel> getAirQuality(double lat, double lon) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.airPollution}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}',
      );

      print('🌐 Fetching air quality for: $lat, $lon');

      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return AirQualityModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load air quality data');
      }
    } catch (e) {
      print('❌ Error in getAirQuality: $e');
      rethrow;
    }
  }

  // Search cities by name
  Future<List<GeoLocation>> searchCities(String query) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.geoBaseUrl}${ApiConstants.directGeo}?q=$query&limit=5&appid=${ApiConstants.apiKey}',
      );

      print('🌐 Searching cities: $query');

      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));

      print('📊 Search response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => GeoLocation.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search cities');
      }
    } catch (e) {
      print('❌ Error in searchCities: $e');
      rethrow;
    }
  }

  // Get location name from coordinates (Reverse Geocoding)
  Future<List<GeoLocation>> reverseGeocode(double lat, double lon) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.geoBaseUrl}${ApiConstants.reverseGeo}?lat=$lat&lon=$lon&limit=1&appid=${ApiConstants.apiKey}',
      );

      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => GeoLocation.fromJson(json)).toList();
      } else {
        throw Exception('Failed to reverse geocode');
      }
    } catch (e) {
      print('❌ Error in reverseGeocode: $e');
      rethrow;
    }
  }
}
