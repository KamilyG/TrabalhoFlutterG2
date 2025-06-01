// lib/ui/weather/weather_info_page.dart

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_weather_app/data/services/models/weather_model.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherInfoPage extends StatefulWidget {
  final Weather weather;

  const WeatherInfoPage({Key? key, required this.weather}) : super(key: key);

  @override
  State<WeatherInfoPage> createState() => _WeatherInfoPageState();
}

class _WeatherInfoPageState extends State<WeatherInfoPage> {
  int _selectedIndex = 1; // Aba “Infos” ativa

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Clima'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              RepaintBoundary(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${widget.weather.temperature.toStringAsFixed(1)}°C',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: Colors.black87,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.weather.mainCondition,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.weather.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: RepaintBoundary(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return InfoTile(
                            icon: Icons.thermostat_outlined,
                            label: 'Temp. Máx.',
                            value:
                                '${widget.weather.tempMax.toStringAsFixed(1)}°C',
                          );
                        case 1:
                          return InfoTile(
                            icon: Icons.thermostat_outlined,
                            label: 'Temp. Mín.',
                            value:
                                '${widget.weather.tempMin.toStringAsFixed(1)}°C',
                          );
                        case 2:
                          return InfoTile(
                            icon: Icons.opacity,
                            label: 'Umidade',
                            value: '${widget.weather.humidity}%',
                          );
                        case 3:
                          return InfoTile(
                            icon: Icons.speed,
                            label: 'Pressão',
                            value: '${widget.weather.pressure} hPa',
                          );
                        case 4:
                          return InfoTile(
                            icon: Icons.air,
                            label: 'Vento',
                            value:
                                '${widget.weather.windSpeed.toStringAsFixed(1)} m/s',
                          );
                        case 5:
                          return const InfoTile(
                            icon: Icons.visibility,
                            label: 'Visibilidade',
                            value: '—',
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 8),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: GNav(
            rippleColor: const Color.fromARGB(255, 224, 224, 224),
            hoverColor: const Color.fromARGB(255, 238, 238, 238),
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
            tabBorder: Border.all(color: Colors.grey.shade300, width: 1),
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
              if (index == 0) {
                Navigator.of(context).pop();
              }
            },
            tabs: const [
              GButton(icon: LineIcons.home, text: 'Home'),
              GButton(icon: LineIcons.search, text: 'Infos'),
              GButton(icon: LineIcons.user, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
