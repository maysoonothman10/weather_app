import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/weather_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = Provider.of<FavoritesProvider>(context);
    final settings = Provider.of<SettingsProvider>(context);
    final weatherProv = Provider.of<WeatherProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ListView.builder(
        itemCount: favs.favorites.length,
        itemBuilder: (context, idx) {
          final city = favs.favorites[idx];
          return ListTile(
            title: Text(city),
            leading: const Icon(Icons.location_city),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => favs.removeFavorite(city),
            ),
            onTap: () async {
              // fetch weather and navigate to details
              await weatherProv.searchCity(city, units: settings.units);
              if (weatherProv.state == WeatherState.loaded &&
                  weatherProv.weather != null) {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: weatherProv.weather,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${weatherProv.errorMessage}')),
                );
              }
            },
          );
        },
      ),
    );
  }
}
