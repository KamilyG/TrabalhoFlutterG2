import 'package:flutter/material.dart';
import 'package:flutter_weather_app/ui/weather/weather_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.viewModel});

  final WeatherViewModel viewModel;

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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clima Atual'),
        ),
        body: SafeArea(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              if (viewModel.getCurrentCity.error) {
                return const Text('Erro');
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // Nome da cidade
                  Text(viewModel.getCurrentCity.toString() ?? "Cidade não encontrada"),

                // Animação do clima
                  Lottie.asset(getWeatherAnimation(viewModel.weather?.mainCondition)),

                // Temperatura
                  Text('${viewModel.weather?.temperature?.round()}°C'),
              ]
              );
            },
          ),
        ),
      ),
    );
  }
}