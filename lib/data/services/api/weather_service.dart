import 'dart:convert';

import 'package:flutter_weather_app/result.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Result<Weather>> getWeather(String cityName) async {
    try {
      final response = await http.get(
          Uri.parse('$BASE_URL?q=$cityName&appid=12be6370e19460a2a5afe25bda79da76&units=metric'));

      if (response.statusCode == 200) {
        return Result.ok(
            Weather.fromJson(jsonDecode(response.body))
        );
      } else {
        return Result.error(Exception());
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  //TODO usar o Result aqui?
  Future<Result<String>> getCurrentCity() async {
    try {
      //pega permissao de localização do usuario
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      //busca localizacao atual
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high // TODO usar LocationSettings class
      );

      //converte localizacao em lista de marcadores
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      //extrai o nome da cidade do primeiro marcador
      String? city = placemarks[0].subAdministrativeArea;

      if (city != null) {
        return Result.ok(
            city
        );
      } else {
        return Result.error(Exception());
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}