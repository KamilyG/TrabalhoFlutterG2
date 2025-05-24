import 'package:flutter/material.dart';

import '../../command.dart';
import '../../data/repositories/repository.dart';
import '../../data/services/models/weather_model.dart';
import '../../result.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherViewModel({required Repository repository}) : _repository = repository {
    getWeather = Command1<void, String>(_getWeather);
    getCurrentCity = Command0(_getCurrentCity);

  }

  final Repository _repository;

  Weather? _weather;
  String? _cityName;
  Weather? get weather => _weather;
  String? get cityName => _cityName;

  late Command1<void, String> getWeather;
  late Command0 getCurrentCity;

  Future<Result> _getCurrentCity() async {
    try {
      final result = await _repository.getCurrentCity();
      switch (result) {
        case Ok<String>():
          _cityName = result.value;
        case Error<void>():
      }
      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _getWeather(String cityName) async {
    try {
      final result = await _repository.getWeather(
        cityName: cityName,
      );
      switch (result) {
        case Ok<Weather>():
          _weather = result.value;
        case Error<void>():
      }
      return result;
    } finally {
      notifyListeners();
    }
  }
}