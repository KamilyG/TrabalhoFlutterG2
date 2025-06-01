// lib/view_models/weather_view_model.dart

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/services/models/weather_model.dart';
import 'package:flutter_weather_app/data/repositories/repository.dart';
import 'package:flutter_weather_app/result.dart';
import 'package:flutter_weather_app/command.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherViewModel({required Repository repository})
    : _repository = repository {
    getWeather = Command1<void, String>(_getWeather);
    getCurrentCity = Command0(_getCurrentCity);
  }

  final Repository _repository;

  Weather? _weather;
  String? _cityName;

  Weather? get weather => _weather;
  String? get cityName => _cityName;

  late final Command1<void, String> getWeather;
  late final Command0 getCurrentCity;

  // Índice de aba (0=Home, 1=Infos, 2=Profile)
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTabIndex(int index) {
    if (index == _selectedTabIndex) return;
    _selectedTabIndex = index;
    notifyListeners();
  }

  Future<Result> _getCurrentCity() async {
    try {
      final result = await _repository.getCurrentCity();
      if (result is Ok<String>) {
        _cityName = result.value;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _getWeather(String cityName) async {
    try {
      final result = await _repository.getWeather(cityName: cityName);
      if (result is Ok<Weather>) {
        _weather = result.value;
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}
