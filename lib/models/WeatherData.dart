class WeatherData {
  final DateTime date; // Time of data calculation, unix, UTC
  final String name; // City name
  final double temp; // Temperature
  final String main; // Group of weather parameters (Rain, Snow, Extreme etc.)
  final String icon; // Weather icon id
  final int humid; // Humidity, %
  final double windSpeed; // Wind speed, meter/sec;
  final double minTemp;
  final double maxTemp;

  WeatherData({this.date,this.name,this.temp,this.main,this.icon,this.humid,this.windSpeed,this.minTemp,this.maxTemp});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
        date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000,
            isUtc: false),
        name: json['name'],
        temp: json['main']['temp'].toDouble(),
        main: json['weather'][0]['main'],
        icon: json['weather'][0]['icon'],
        humid: json['main']['humidity'],
        windSpeed: json['wind']['speed'].toDouble(),
        minTemp: json['main']['temp_min'].toDouble(),
        maxTemp: json['main']['temp_max'].toDouble()
    );
  }
}