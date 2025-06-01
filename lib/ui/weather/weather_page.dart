// lib/ui/weather/weather_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/services/models/weather_model.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_weather_app/ui/weather/weather_view_model.dart';
import 'package:flutter_weather_app/ui/weather/weather_info_page.dart';

class WeatherPage extends StatelessWidget {
  final WeatherViewModel viewModel;

  const WeatherPage({Key? key, required this.viewModel}) : super(key: key);

  String _getWeatherAnimation(String? mainCondition) {
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
    // Solicita a cidade atual e em seguida o clima
    viewModel.getCurrentCity.execute().then((_) {
      final cidade = viewModel.cityName;
      if (cidade != null) {
        viewModel.getWeather.execute(cidade);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima Atual'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, _) {
                    final weather = viewModel.weather;
                    final city = viewModel.cityName;
                    if (weather == null || city == null) {
                      return const CircularProgressIndicator();
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          city,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: Colors.black87),
                        ),
                        const SizedBox(height: 16),
                        Lottie.asset(
                          _getWeatherAnimation(weather.mainCondition),
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${weather.temperature.round()}°C',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Barra de navegação
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 8),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SafeArea(
                child: ListenableBuilder(
                  listenable: viewModel,
                  builder: (context, _) {
                    return GNav(
                      rippleColor: const Color.fromARGB(255, 224, 224, 224),
                      hoverColor: const Color.fromARGB(255, 238, 238, 238),
                      haptic: true,
                      tabBorderRadius: 15,
                      tabActiveBorder: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                      tabBorder: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      tabShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                      curve: Curves.easeOutExpo,
                      duration: const Duration(milliseconds: 600),
                      gap: 8,
                      color: Colors.grey[700],
                      activeColor: Theme.of(context).colorScheme.primary,
                      iconSize: 24,
                      tabBackgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      selectedIndex: viewModel.selectedTabIndex,
                      onTabChange: (index) {
                        viewModel.setSelectedTabIndex(index);
                        switch (index) {
                          case 0:
                            // Home (já estamos aqui)
                            break;

                          case 1:
                            final weatherData = viewModel.weather;
                            final cityName = viewModel.cityName;
                            if (weatherData != null && cityName != null) {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (_) => WeatherInfoPage(
                                        weather: Weather(
                                          cityName: cityName,
                                          temperature: weatherData.temperature,
                                          tempMin: weatherData.tempMin,
                                          tempMax: weatherData.tempMax,
                                          humidity: weatherData.humidity,
                                          pressure: weatherData.pressure,
                                          windSpeed: weatherData.windSpeed,
                                          mainCondition:
                                              weatherData.mainCondition,
                                          description: weatherData.description,
                                        ),
                                      ),
                                    ),
                                  )
                                  .then((_) {
                                    viewModel.setSelectedTabIndex(0);
                                  });
                            }
                            break;

                          case 2:
                            // Futuro “Profile”
                            break;
                        }
                      },
                      tabs: const [
                        GButton(icon: LineIcons.home, text: 'Home'),
                        GButton(icon: LineIcons.search, text: 'Infos'),
                        GButton(icon: LineIcons.user, text: 'Profile'),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
