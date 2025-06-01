// lib/data/services/models/weather_model.dart

class Weather {
  final String cityName;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final String mainCondition;
  final String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.mainCondition,
    required this.description,
  });

  /// Faz o parsing manual do JSON retornado pela API OpenWeatherMap
  factory Weather.fromJson(Map<String, dynamic> json) {
    // “main” é um Map contendo temp, temp_min, temp_max, humidity, pressure
    final main = json['main'] as Map<String, dynamic>;

    // “wind” é um Map contendo speed
    final wind = json['wind'] as Map<String, dynamic>;

    // “weather” é uma lista de objetos; usamos o primeiro
    final weatherList = json['weather'] as List<dynamic>;
    final firstWeather = (weatherList.isNotEmpty)
        ? weatherList[0] as Map<String, dynamic>
        : <String, dynamic>{'main': '', 'description': ''};

    return Weather(
      cityName: json['name'] as String,
      temperature: (main['temp'] as num).toDouble(),
      tempMin: (main['temp_min'] as num).toDouble(),
      tempMax: (main['temp_max'] as num).toDouble(),
      humidity: (main['humidity'] as num).toInt(),
      pressure: (main['pressure'] as num).toInt(),
      windSpeed: (wind['speed'] as num).toDouble(),
      mainCondition: firstWeather['main'] as String,
      description: firstWeather['description'] as String,
    );
  }

  /// (Opcional) Serialização de volta para JSON
  Map<String, dynamic> toJson() => {
    'name': cityName,
    'main': {
      'temp': temperature,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'humidity': humidity,
      'pressure': pressure,
    },
    'wind': {'speed': windSpeed},
    'weather': [
      {'main': mainCondition, 'description': description},
    ],
  };
}
