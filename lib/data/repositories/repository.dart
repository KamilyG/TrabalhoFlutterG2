import 'package:flutter_weather_app/data/services/models/weather_model.dart';

import '../../result.dart';
import '../services/api/weather_service.dart';

class Repository {
  Repository({required WeatherService client}) : _client = client;

  final WeatherService _client;

  Future<Result<Weather>> getWeather({
    required String cityName,
  }) async {
    try {
      return await _client.getWeather(
        cityName,
      );
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<String>> getCurrentCity() async {
    try {
      return await _client.getCurrentCity();
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}