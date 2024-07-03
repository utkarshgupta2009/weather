class Weather {
  final String cityName;
  final String countryName;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final String mainInformation;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.countryName,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.mainInformation,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      countryName: json['sys']['country'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      mainInformation: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}