🌤 Flutter Weather App

A beautiful and functional Flutter weather application that allows users to search for cities, view weather details, manage favorites, and switch between Celsius and Fahrenheit. Built with real-time data from the OpenWeather API.

📝 Features

🔍 Search for any city worldwide

🌡 Weather details: temperature, humidity, weather condition, wind speed, etc.

⭐ Favorites: Add and view favorite cities

🌐 Settings: Switch temperature units between Celsius (°C) and Fahrenheit (°F)

⚡ Real-time API calls to fetch current weather data


⚙️ Setup Instructions
1. Clone the repository
git clone https://github.com/maysoonothman10/weather_app.git
cd weather_app

2. Install dependencies
flutter pub get

3. Add your OpenWeather API Key

If using config.dart:

const String OPENWEATHER_API_KEY = "YOUR_API_KEY_HERE";


If using .env with flutter_dotenv:

OPENWEATHER_API_KEY=YOUR_API_KEY_HERE

4. Run the app
flutter run

5. Build APK for Android
flutter build apk --release


The release APK will be located at:
build/app/outputs/flutter-apk/app-release.apk

This APK is required for submission, so your teacher/tester can install it on Android devices.

🔗 API

This app uses the OpenWeather API
 to fetch weather data.

Sign up for a free API key

Replace the placeholder in config.dart or .env with your key
