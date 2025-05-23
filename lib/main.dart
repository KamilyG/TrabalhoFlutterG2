import 'package:flutter/material.dart';
import 'package:flutter_weather_app/pages/weather_page.dart';
import 'package:flutter_weather_app/data/services/weather_service.dart';
import 'package:flutter_weather_app/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherViewModel(WeatherService('12be6370e19460a2a5afe25bda79da76')),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherPage(),
      ),
    );
  }
}
