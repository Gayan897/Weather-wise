import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/geo_location.dart';

class FavoritesRepository {
  static const String _key = 'favorite_cities';

  Future<List<GeoLocation>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_key);

      if (favoritesJson == null) {
        return [];
      }

      final List<dynamic> decoded = json.decode(favoritesJson);
      return decoded.map((item) => GeoLocation.fromJson(item)).toList();
    } catch (e) {
      print('❌ Error getting favorites: $e');
      return [];
    }
  }

  Future<bool> addFavorite(GeoLocation location) async {
    try {
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
    } catch (e) {
      print('❌ Error adding favorite: $e');
      return false;
    }
  }

  Future<bool> removeFavorite(GeoLocation location) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere(
        (fav) => fav.lat == location.lat && fav.lon == location.lon,
      );
      return _saveFavorites(favorites);
    } catch (e) {
      print('❌ Error removing favorite: $e');
      return false;
    }
  }

  Future<bool> isFavorite(GeoLocation location) async {
    try {
      final favorites = await getFavorites();
      return favorites.any(
        (fav) => fav.lat == location.lat && fav.lon == location.lon,
      );
    } catch (e) {
      print('❌ Error checking favorite: $e');
      return false;
    }
  }

  Future<bool> _saveFavorites(List<GeoLocation> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded = json.encode(
        favorites.map((loc) => loc.toJson()).toList(),
      );
      return prefs.setString(_key, encoded);
    } catch (e) {
      print('❌ Error saving favorites: $e');
      return false;
    }
  }

  Future<bool> clearFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(_key);
    } catch (e) {
      print('❌ Error clearing favorites: $e');
      return false;
    }
  }
}
