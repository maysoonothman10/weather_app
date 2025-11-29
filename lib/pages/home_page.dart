import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../providers/settings_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final List<String> _history = [];

  @override
  Widget build(BuildContext context) {
    final weatherProv = Provider.of<WeatherProvider>(context);
    final settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather - Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'City name',
                      hintText: 'e.g. London',
                    ),
                    onSubmitted: (v) => _doSearch(v, settings.units),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _doSearch(_controller.text, settings.units),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_history.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 8,
                children: _history
                    .map(
                      (c) => ActionChip(
                        label: Text(c),
                        onPressed: () => _doSearch(c, settings.units),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
            ],
            Expanded(
              child: Center(
                child: Builder(
                  builder: (_) {
                    if (weatherProv.state == WeatherState.initial) {
                      return const Text('Search for a city to view weather.');
                    } else if (weatherProv.state == WeatherState.loading) {
                      return const CircularProgressIndicator();
                    } else if (weatherProv.state == WeatherState.error) {
                      return Text('Error: ${weatherProv.errorMessage}');
                    } else if (weatherProv.weather != null) {
                      // show a simplified preview and a button to go to details
                      final w = weatherProv.weather!;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${w.cityName} — ${w.temp.toStringAsFixed(1)} ${settings.tempSymbol}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 8),
                          Text(w.description),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/details',
                                arguments: w,
                              );
                            },
                            child: const Text('View details'),
                          ),
                        ],
                      );
                    } else {
                      return const Text('No data');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _doSearch(String city, String units) {
    final cleaned = city.trim();
    if (cleaned.isEmpty) return;
    final weatherProv = Provider.of<WeatherProvider>(context, listen: false);
    weatherProv.searchCity(cleaned, units: units);
    setState(() {
      _history.remove(cleaned);
      _history.insert(0, cleaned);
      if (_history.length > 6) _history.removeLast();
    });
  }
}
