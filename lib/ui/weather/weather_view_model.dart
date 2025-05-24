import 'package:flutter/material.dart';
import '../../data/services/models/weather_model.dart';
import 'package:flutter_weather_app/data/services/api/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {

  // TODO ajeitar view model
  /*final WeatherService _weatherService;
  Weather? _weather;

  Weather? get weather => _weather;

  WeatherViewModel(this._weatherService);

  // Método para buscar o clima
  Future<void> fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      _weather = await _weatherService.getWeather(cityName);
      notifyListeners(); // Notifica a UI que o estado mudou
    } catch (e) {
      print("Erro ao buscar o clima: $e");
    }
  }*/
}
