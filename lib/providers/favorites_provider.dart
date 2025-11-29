import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => List.unmodifiable(_favorites);

  Future<void> loadFavorites() async {
    final stored = await StorageService.loadFavorites();
    _favorites.clear();
    _favorites.addAll(stored);
    notifyListeners();
  }

  Future<void> addFavorite(String city) async {
    if (!_favorites.contains(city)) {
      _favorites.add(city);
      await StorageService.saveFavorites(_favorites);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String city) async {
    _favorites.remove(city);
    await StorageService.saveFavorites(_favorites);
    notifyListeners();
  }
}
