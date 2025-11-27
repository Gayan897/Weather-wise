// lib/data/repositories/favorites_repository.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:weather_app/data/models/geo_location.dart';

class FavoritesRepository {
  static const String _key = 'favorite_cities';

  Future<List<GeoLocation>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_key);

    if (favoritesJson == null) {
      return [];
    }

    final List<dynamic> decoded = json.decode(favoritesJson);
    return decoded.map((item) => GeoLocation.fromJson(item)).toList();
  }

  Future<bool> addFavorite(GeoLocation location) async {
    final favorites = await getFavorites();
    
    // Check if already exists
    final exists = favorites.any(
      (fav) => fav.lat == location.lat && fav.lon == location.lon,
    );

    if (exists) {
      return false;
    }

    favorites.add(location);
    return _saveFavorites(favorites);
  }

  Future<bool> removeFavorite(GeoLocation location) async {
    final favorites = await getFavorites();
    favorites.removeWhere(
      (fav) => fav.lat == location.lat && fav.lon == location.lon,
    );
    return _saveFavorites(favorites);
  }

  Future<bool> isFavorite(GeoLocation location) async {
    final favorites = await getFavorites();
    return favorites.any(
      (fav) => fav.lat == location.lat && fav.lon == location.lon,
    );
  }

  Future<bool> _saveFavorites(List<GeoLocation> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(
      favorites.map((loc) => loc.toJson()).toList(),
    );
    return prefs.setString(_key, encoded);
  }

  Future<bool> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_key);
  }
}