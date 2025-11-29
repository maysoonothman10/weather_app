# Flutter Weather App (OpenWeatherMap Current Weather)

## Description
A multi-page Flutter application that fetches current weather data from OpenWeatherMap API. Features search by city, detailed weather view, favorites list, and settings (°C/°F, language, GPS toggle).

## Features
- Search weather by city name
- View detailed weather (temp, feels like, humidity, wind, sunrise/sunset, local time)
- Save cities to favorites
- Settings to switch temperature units (metric/imperial)
- Local persistence using `shared_preferences`
- Clean, responsive UI

## Setup
1. Clone repository.
2. Get an API key from OpenWeatherMap: https://openweathermap.org/api
3. **Do not commit your API key**. Use one of:
   - Create `lib/config.dart`:
     ```dart
     const String OPENWEATHER_API_KEY = 'YOUR_KEY';
     ```
     and add `/lib/config.dart` to `.gitignore`.
   - Or create a `.env` file and use `flutter_dotenv`.
4. Install packages:
