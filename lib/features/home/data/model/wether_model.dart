class Weather {
  final String cityName;
  final double temperature;
  final int humidity;
  final String description;
  final String icon;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.description,
    required this.icon,
  });

  // Factory constructor to create a Weather object from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
