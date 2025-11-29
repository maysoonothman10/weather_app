import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SettingsProvider extends ChangeNotifier {
  bool useMetric = true; // default Celsius
  String? language;
  bool useGps = false;

  void toggleUnit() {
    useMetric = !useMetric;
    _save();
    notifyListeners();
  }

  Future<void> loadSettings() async {
    final stored = await StorageService.loadSettings();
    if (stored.containsKey('useMetric'))
      useMetric = stored['useMetric'] as bool;
    if (stored.containsKey('language'))
      language = stored['language'] as String?;
    if (stored.containsKey('useGps')) useGps = stored['useGps'] as bool;
    notifyListeners();
  }

  void setLanguage(String lang) {
    language = lang;
    _save();
    notifyListeners();
  }

  void setUseGps(bool val) {
    useGps = val;
    _save();
    notifyListeners();
  }

  void _save() {
    StorageService.saveSettings({
      'useMetric': useMetric,
      'language': language,
      'useGps': useGps,
    });
  }

  String get units => useMetric ? 'metric' : 'imperial';
  String get tempSymbol => useMetric ? '°C' : '°F';
}
