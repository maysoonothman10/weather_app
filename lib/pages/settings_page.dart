import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Temperature unit'),
              subtitle: Text(
                settings.useMetric ? 'Metric (°C)' : 'Imperial (°F)',
              ),
              trailing: Switch(
                value: settings.useMetric,
                onChanged: (_) => settings.toggleUnit(),
              ),
            ),
            ListTile(
              title: const Text('Language'),
              subtitle: Text(settings.language ?? 'System/default'),
              onTap: () {
                // optional: show dialog to choose language
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text('Choose language (optional)'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            settings.setLanguage('en');
                            Navigator.pop(context);
                          },
                          child: const Text('English'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            settings.setLanguage('ar');
                            Navigator.pop(context);
                          },
                          child: const Text('Arabic'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            settings.setLanguage('es');
                            Navigator.pop(context);
                          },
                          child: const Text('Spanish'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Use GPS location'),
              subtitle: const Text('(Optional)'),
              trailing: Switch(
                value: settings.useGps,
                onChanged: (v) => settings.setUseGps(v),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
