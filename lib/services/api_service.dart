import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
import '../config.dart'; // make sure this is gitignored or use dotenv

class ApiService {
  static const _base = 'https://api.openweathermap.org/data/2.5/weather';

  // units: 'metric' or 'imperial'
  static Future<Weather> fetchWeatherByCity(
    String city,
    String apiKey, {
    String units = 'metric',
    String? lang,
  }) async {
    final params = {'q': city, 'appid': apiKey, 'units': units};
    if (lang != null) params['lang'] = lang;

    final uri = Uri.parse(_base).replace(queryParameters: params);
    final resp = await http.get(uri).timeout(const Duration(seconds: 10));
    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      return Weather.fromJson(data);
    } else if (resp.statusCode == 401) {
      throw ApiException('Invalid API key (401).');
    } else if (resp.statusCode == 404) {
      throw ApiException('City not found (404).');
    } else {
      throw ApiException('API error: ${resp.statusCode} ${resp.reasonPhrase}');
    }
  }

  static Future<Weather> fetchWeatherByCoords(
    double lat,
    double lon,
    String apiKey, {
    String units = 'metric',
  }) async {
    final params = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': apiKey,
      'units': units,
    };
    final uri = Uri.parse(_base).replace(queryParameters: params);
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      return Weather.fromJson(json.decode(resp.body));
    } else {
      throw ApiException('API error: ${resp.statusCode}');
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
