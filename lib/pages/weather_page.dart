import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/models/weather_model.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';

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
          Text(_weather?.cityName ?? "Carregando cidade..."),

          Text('${_weather?.temperature.round()}°C')
        ],
      ),
    );
  }
}
