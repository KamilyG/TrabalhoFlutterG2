import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/models/weather_model.dart';
import 'package:flutter_weather_app/viewmodels/weather_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  // Animações baseadas na condição do clima
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Sunny.json'; // animação default

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
  Widget build(BuildContext context) {
    // O WeatherViewModel é fornecido aqui pelo Provider
    final weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Clima Atual'),
      ),
      body: FutureBuilder(
        // Carrega o clima ao iniciar
        future: weatherViewModel.fetchWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          }

          Weather? weather = weatherViewModel.weather;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nome da cidade
                Text(weather?.cityName ?? "Cidade não encontrada"),

                // Animação do clima
                Lottie.asset(getWeatherAnimation(weather?.mainCondition)),

                // Temperatura
                Text('${weather?.temperature.round()}°C'),
              ],
            ),
          );
        },
      ),
    );
  }
}
