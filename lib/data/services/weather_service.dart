import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter_weather_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {

  static const BASE_URL = 'open weather map org link';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar informações do clima');
    }
  }

  Future<String> getCurrentCity() async {
    //pega permissao de localização do usuario
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //busca localizacao atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high // usar LocationSettings class
    );

    //converte localizacao em lista de marcadores
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    //extrai o nome da cidade do primeiro marcador
    String? city = placemarks[0].locality;

    return city ?? "";

  }
}