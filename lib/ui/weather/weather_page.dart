import 'package:flutter/material.dart';
import 'package:flutter_weather_app/ui/weather/weather_view_model.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.viewModel});

  final WeatherViewModel viewModel;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  @override
  void initState() {
    super.initState();

    widget.viewModel.getCurrentCity.execute().then((_) {
      final cidade = widget.viewModel.cityName;
      if (cidade != null) {
        widget.viewModel.getWeather.execute(cidade);
      }
    });
  }

  // Define qual animação exibir com base na condição do clima
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Sunny.json';
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
        appBar: AppBar(title: const Text('Clima Atual')),
        body: SafeArea(
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, _) {
              final weather = widget.viewModel.weather;
              final city = widget.viewModel.cityName;

              if (weather == null || city == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nome da cidade
                  Text(city, style: const TextStyle(fontSize: 20)),

                  const SizedBox(height: 20),

                  // Animação do clima
                  Lottie.asset(
                    getWeatherAnimation(weather.mainCondition),
                    width: 200,
                    height: 200,
                  ),

                  const SizedBox(height: 20),

                  // Temperatura
                  Text(
                    '${weather.temperature?.round()}°C',
                    style: const TextStyle(fontSize: 28),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
