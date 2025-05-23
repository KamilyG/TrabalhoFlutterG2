import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/models/weather_model.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weathersService = WeatherService('12be6370e19460a2a5afe25bda79da76');
  Weather? _weather;

  // busca weather
  _fetchWeather() async {
    String cityName = await _weathersService.getCurrentCity();

    try {
      final weather = await _weathersService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // animação do weather
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Sunny.json'; // animacao default

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Rain.json';
      case 'thunderstorm':
        return 'assets/Thunder.json';
      default:
        return 'assets/Sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    // busca weather ao iniciar
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // cidade
          Text(_weather?.cityName ?? "Carregando cidade..."),

          // animacao
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          // temperatura
          Text('${_weather?.temperature.round()}°C')
        ],
      ),
    );
  }
}
