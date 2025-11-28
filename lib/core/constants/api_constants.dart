// lib/core/constants/api_constants.dart
class ApiConstants {
  // OpenWeatherMap API Configuration
  static const String apiKey =
      '437ed004c92a9f4c48e5f4be6f788d8f'; // Replace with actual key
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String geoBaseUrl = 'https://api.openweathermap.org/geo/1.0';

  // API Endpoints
  static const String currentWeather = '/weather';
  static const String forecast = '/forecast';
  static const String airPollution = '/air_pollution';
  static const String oneCall = '/onecall';
  static const String directGeo = '/direct';
  static const String reverseGeo = '/reverse';

  // Map Tiles
  static const String weatherMapTiles =
      'https://tile.openweathermap.org/map/{layer}/{z}/{x}/{y}.png?appid=$apiKey';
}

// lib/core/constants/app_constants.dart
class AppConstants {
  static const String appName = 'Weather Wise';
  static const int maxFavoriteCities = 10;
  static const int cacheExpiryHours = 1;
  static const double defaultLatitude = 6.9271;
  static const double defaultLongitude = 79.8612;

  // Temperature Units
  static const String metric = 'metric';
  static const String imperial = 'imperial';
  static const String standard = 'standard';

  // Weather Conditions
  static const Map<String, String> weatherIcons = {
    '01d': '☀️',
    '01n': '🌙',
    '02d': '🌤️',
    '02n': '☁️',
    '03d': '☁️',
    '03n': '☁️',
    '04d': '☁️',
    '04n': '☁️',
    '09d': '🌧️',
    '09n': '🌧️',
    '10d': '🌦️',
    '10n': '🌧️',
    '11d': '⛈️',
    '11n': '⛈️',
    '13d': '🌨️',
    '13n': '🌨️',
    '50d': '🌫️',
    '50n': '🌫️',
  };
}
