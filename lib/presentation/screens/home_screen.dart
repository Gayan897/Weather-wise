// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/settings_screen.dart';
import '../providers/weather_providers.dart';
import 'search_screen.dart';
import 'favorites_screen.dart';
import 'forecast_screen.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String selectedCity = 'Colombo';
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(currentWeatherProvider(selectedCity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Wise'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
              if (result != null && result is String) {
                setState(() {
                  selectedCity = result;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentWeatherProvider(selectedCity));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Weather Card
                weatherAsync.when(
                  data: (weather) => Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade700,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                weather.name,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat(
                                  'EEEE, MMMM d',
                                ).format(DateTime.now()),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://openweathermap.org/img/wn/${weather.weather[0].icon}@4x.png',
                                    width: 100,
                                    height: 100,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.cloud,
                                        size: 100,
                                        color: Colors.white,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${weather.main.temp.round()}°C',
                                        style: const TextStyle(
                                          fontSize: 56,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        weather.weather[0].description
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _WeatherDetail(
                                    icon: Icons.thermostat,
                                    label: 'Feels Like',
                                    value:
                                        '${weather.main.feelsLike.round()}°C',
                                  ),
                                  _WeatherDetail(
                                    icon: Icons.water_drop,
                                    label: 'Humidity',
                                    value: '${weather.main.humidity}%',
                                  ),
                                  _WeatherDetail(
                                    icon: Icons.air,
                                    label: 'Wind',
                                    value:
                                        '${weather.wind.speed.toStringAsFixed(1)} m/s',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Additional Details Card
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _DetailRow(
                                icon: Icons.compress,
                                label: 'Pressure',
                                value: '${weather.main.pressure} hPa',
                              ),
                              const Divider(),
                              _DetailRow(
                                icon: Icons.visibility,
                                label: 'Visibility',
                                value:
                                    '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                              ),
                              const Divider(),
                              _DetailRow(
                                icon: Icons.wb_sunny,
                                label: 'Sunrise',
                                value: DateFormat('HH:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    weather.sys.sunrise * 1000,
                                  ),
                                ),
                              ),
                              const Divider(),
                              _DetailRow(
                                icon: Icons.wb_twilight,
                                label: 'Sunset',
                                value: DateFormat('HH:mm').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    weather.sys.sunset * 1000,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ForecastScreen(cityName: selectedCity),
                            ),
                          );
                        },
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('View 5-Day Forecast'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                    ],
                  ),
                  loading: () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Loading weather data for $selectedCity...',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  error: (error, stack) {
                    print('🔥 Error in UI: $error');
                    return Card(
                      color: Colors.red.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Error Loading Weather',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: Colors.red.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              error.toString().replaceAll('Exception:', ''),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '💡 Troubleshooting Tips:',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '1. Check your internet connection\n'
                              '2. Verify your API key is correct\n'
                              '3. Make sure the city name is valid\n'
                              '4. Try a different city (e.g., London, Paris)',
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    ref.invalidate(
                                      currentWeatherProvider(selectedCity),
                                    );
                                  },
                                  icon: const Icon(Icons.refresh),
                                  label: const Text('Retry'),
                                ),
                                const SizedBox(width: 12),
                                OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      selectedCity = 'London';
                                    });
                                    ref.invalidate(
                                      currentWeatherProvider('London'),
                                    );
                                  },
                                  icon: const Icon(Icons.home),
                                  label: const Text('Try London'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ).then((_) {
              setState(() {
                _selectedIndex = 0;
              });
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blue),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
