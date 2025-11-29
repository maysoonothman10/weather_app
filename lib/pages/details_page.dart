import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../providers/favorites_provider.dart';
import '../providers/settings_provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  String _formatLocalTime(int unix, int tzOffset) {
    final dt = DateTime.fromMillisecondsSinceEpoch(
      (unix + tzOffset) * 1000,
      isUtc: true,
    );
    return DateFormat('yyyy-MM-dd HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final Weather w = ModalRoute.of(context)!.settings.arguments as Weather;
    final favorites = Provider.of<FavoritesProvider>(context);
    final settings = Provider.of<SettingsProvider>(context);
    final iconUrl = 'https://openweathermap.org/img/wn/${w.icon}@2x.png';
    final isFav = favorites.favorites.contains(w.cityName);

    return Scaffold(
      appBar: AppBar(
        title: Text(w.cityName),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.star : Icons.star_border),
            onPressed: () {
              if (isFav) {
                favorites.removeFavorite(w.cityName);
              } else {
                favorites.addFavorite(w.cityName);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(iconUrl),
            Text(
              '${w.temp.toStringAsFixed(1)} ${settings.tempSymbol}',
              style: const TextStyle(fontSize: 36),
            ),
            Text(w.description, style: const TextStyle(fontSize: 18)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Feels like: ${w.feelsLike.toStringAsFixed(1)} ${settings.tempSymbol}',
                ),
                Text('Humidity: ${w.humidity}%'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Wind: ${w.windSpeed} m/s'),
                Text(
                  'Local time: ${_formatLocalTime(DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000, w.timezoneOffset)}',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sunrise: ${_formatLocalTime(w.sunrise, w.timezoneOffset)}',
                ),
                Text('Sunset: ${_formatLocalTime(w.sunset, w.timezoneOffset)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
