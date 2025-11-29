import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/api_service.dart';
import '../config.dart'; // or use dotenv

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  WeatherState state = WeatherState.initial;
  Weather? weather;
  String? errorMessage;

  Future<void> searchCity(
    String city, {
    required String units,
    String? lang,
  }) async {
    state = WeatherState.loading;
    errorMessage = null;
    notifyListeners();
    try {
      final w = await ApiService.fetchWeatherByCity(
        city,
        OPENWEATHER_API_KEY,
        units: units,
        lang: lang,
      );
      weather = w;
      state = WeatherState.loaded;
    } catch (e) {
      state = WeatherState.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void clear() {
    weather = null;
    state = WeatherState.initial;
    errorMessage = null;
    notifyListeners();
  }
}
