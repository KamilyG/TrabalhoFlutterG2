import 'package:flutter/material.dart';
import 'package:flutter_weather_app/router.dart';
import 'package:provider/provider.dart';

import 'data/repositories/repository.dart';
import 'data/services/api/weather_service.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          Provider(create: (context) => WeatherService()),
          Provider(create: (context) => Repository(client: context.read())),
        ], child: MaterialApp.router(
        routerConfig: router(),
        debugShowCheckedModeBanner: false,
      ),
      ),
  );
}