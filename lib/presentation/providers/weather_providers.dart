// lib/presentation/providers/weather_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/data/models/air_quality_model.dart';
import 'package:weather_app/data/models/forecast_model.dart';
import 'package:weather_app/data/models/geo_location.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../data/models/weather_model.dart';


// Repository Providers
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository();
});

// Current Weather Provider
final currentWeatherProvider = StateNotifierProvider.family<
    CurrentWeatherNotifier, AsyncValue<WeatherModel>, String>(
  (ref, cityName) {
    final repository = ref.watch(weatherRepositoryProvider);
    return CurrentWeatherNotifier(repository, cityName);
  },
);

class CurrentWeatherNotifier extends StateNotifier<AsyncValue<WeatherModel>> {
  final WeatherRepository _repository;
  final String cityName;

  CurrentWeatherNotifier(this._repository, this.cityName)
      : super(const AsyncValue.loading()) {
    loadWeather();
  }

  Future<void> loadWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getCurrentWeather(cityName));
  }

  Future<void> refresh() async {
    await loadWeather();
  }
}

// Weather by Coordinates Provider
final weatherByLocationProvider = StateNotifierProvider.family<
    WeatherByLocationNotifier, AsyncValue<WeatherModel>, LocationCoords>(
  (ref, coords) {
    final repository = ref.watch(weatherRepositoryProvider);
    return WeatherByLocationNotifier(repository, coords);
  },
);

class WeatherByLocationNotifier
    extends StateNotifier<AsyncValue<WeatherModel>> {
  final WeatherRepository _repository;
  final LocationCoords coords;

  WeatherByLocationNotifier(this._repository, this.coords)
      : super(const AsyncValue.loading()) {
    loadWeather();
  }

  Future<void> loadWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.getCurrentWeatherByCoords(coords.lat, coords.lon),
    );
  }
}

class LocationCoords {
  final double lat;
  final double lon;

  LocationCoords(this.lat, this.lon);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationCoords &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lon == other.lon;

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}

// Forecast Provider
final forecastProvider = StateNotifierProvider.family<ForecastNotifier,
    AsyncValue<ForecastModel>, String>(
  (ref, cityName) {
    final repository = ref.watch(weatherRepositoryProvider);
    return ForecastNotifier(repository, cityName);
  },
);

class ForecastNotifier extends StateNotifier<AsyncValue<ForecastModel>> {
  final WeatherRepository _repository;
  final String cityName;

  ForecastNotifier(this._repository, this.cityName)
      : super(const AsyncValue.loading()) {
    loadForecast();
  }

  Future<void> loadForecast() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getForecast(cityName));
  }
}

// Air Quality Provider
final airQualityProvider = StateNotifierProvider.family<AirQualityNotifier,
    AsyncValue<AirQualityModel>, LocationCoords>(
  (ref, coords) {
    final repository = ref.watch(weatherRepositoryProvider);
    return AirQualityNotifier(repository, coords);
  },
);

class AirQualityNotifier extends StateNotifier<AsyncValue<AirQualityModel>> {
  final WeatherRepository _repository;
  final LocationCoords coords;

  AirQualityNotifier(this._repository, this.coords)
      : super(const AsyncValue.loading()) {
    loadAirQuality();
  }

  Future<void> loadAirQuality() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _repository.getAirQuality(coords.lat, coords.lon),
    );
  }
}

// City Search Provider
final citySearchProvider =
    StateNotifierProvider<CitySearchNotifier, AsyncValue<List<GeoLocation>>>(
  (ref) {
    final repository = ref.watch(weatherRepositoryProvider);
    return CitySearchNotifier(repository);
  },
);

class CitySearchNotifier extends StateNotifier<AsyncValue<List<GeoLocation>>> {
  final WeatherRepository _repository;

  CitySearchNotifier(this._repository) : super(const AsyncValue.data([]));

  Future<void> searchCities(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.searchCities(query));
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

// Favorites Provider
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, AsyncValue<List<GeoLocation>>>(
  (ref) {
    final repository = ref.watch(favoritesRepositoryProvider);
    return FavoritesNotifier(repository);
  },
);

class FavoritesNotifier extends StateNotifier<AsyncValue<List<GeoLocation>>> {
  final FavoritesRepository _repository;

  FavoritesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getFavorites());
  }

  Future<void> addFavorite(GeoLocation location) async {
    await _repository.addFavorite(location);
    await loadFavorites();
  }

  Future<void> removeFavorite(GeoLocation location) async {
    await _repository.removeFavorite(location);
    await loadFavorites();
  }

  Future<bool> isFavorite(GeoLocation location) async {
    return _repository.isFavorite(location);
  }

  Future<void> clearAll() async {
    await _repository.clearFavorites();
    await loadFavorites();
  }
}

// Selected City Provider (for navigation between screens)
final selectedCityProvider = StateProvider<GeoLocation?>((ref) => null);

// Temperature Unit Provider
final temperatureUnitProvider = StateProvider<String>((ref) => 'metric');

// Theme Mode Provider
final themeModeProvider = StateProvider<bool>((ref) => false); // false = light, true = dark