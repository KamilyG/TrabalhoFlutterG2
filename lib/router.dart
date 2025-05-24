import 'package:flutter_weather_app/routes.dart';
import 'package:flutter_weather_app/ui/weather/weather_page.dart';
import 'package:flutter_weather_app/ui/weather/weather_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = WeatherViewModel(repository: context.read());
        return WeatherPage(viewModel: viewModel);
      },
    ),
  ],
);