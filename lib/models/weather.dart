class Weather {
  final String cityName;
  final double temp;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int sunrise; // unix
  final int sunset; // unix
  final int timezoneOffset; // seconds
  final String icon; // icon code

  Weather({
    required this.cityName,
    required this.temp,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.timezoneOffset,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeed: (json['wind']?['speed'] ?? 0).toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      timezoneOffset: json['timezone'],
      icon: json['weather'][0]['icon'],
    );
  }
}
