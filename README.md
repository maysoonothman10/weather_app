# Flutter Weather App 🌤️

A simple Flutter weather application that allows users to search for cities, view weather details, save favorites, and change units (°C/°F).  

---

## **Features**
- Search for any city worldwide.
- Display detailed weather information (temperature, humidity, weather condition, etc.).
- Add cities to favorites and view them later.
- Switch between Celsius and Fahrenheit.
- Real-time API calls with OpenWeatherMap.

---

## **Folder Structure**
weather_app/
├── android/ # Android project files
├── ios/ # iOS project files
├── lib/
│ ├── models/ # Data models (e.g., Weather model)
│ ├── services/ # API services
│ ├── screens/ # UI screens
│ ├── widgets/ # Reusable widgets
│ ├── config.dart # API key configuration
│ ├── main.dart # App entry point
├── assets/ # Images, icons, fonts
├── build/ # Build output (ignored in Git)
├── pubspec.yaml # Flutter dependencies
└── README.md # Project documentation

yaml
Copy code

---

## **Setup & Installation**

### **1. Clone the project**
```bash
git clone https://github.com/maysoonothman10/weather_app.git
cd weather_app
2. Install dependencies
bash
Copy code
flutter pub get
3. Add your OpenWeather API key
Open the file lib/config.dart.

Replace the placeholder with your actual API key:

dart
Copy code
// lib/config.dart
const String OPENWEATHER_API_KEY = "YOUR_API_KEY_HERE";
⚠️ Important: Keep your API key private. Do not push it to public repositories.

4. Run the app
For Android:

bash
Copy code
flutter run -d android
For Windows:

bash
Copy code
flutter run -d windows
For Web:

bash
Copy code
flutter run -d chrome
Build APK for Android
bash
Copy code
flutter build apk --release
The APK will be generated at:

swift
Copy code
build/app/outputs/flutter-apk/app-release.apk
You can upload this APK along with your project to GitHub.
