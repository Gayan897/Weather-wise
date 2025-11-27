// lib/presentation/screens/forecast_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/weather_providers.dart';

class ForecastScreen extends ConsumerWidget {
  final String cityName;

  const ForecastScreen({super.key, required this.cityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastAsync = ref.watch(forecastProvider(cityName));

    return Scaffold(
      appBar: AppBar(
        title: Text('$cityName Forecast'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(forecastProvider(cityName));
            },
          ),
        ],
      ),
      body: forecastAsync.when(
        data: (forecast) {
          // Group forecast by days
          final dailyForecasts = <String, List<dynamic>>{};
          for (var item in forecast.list) {
            final date = DateFormat(
              'yyyy-MM-dd',
            ).format(DateTime.parse(item.dtTxt));
            if (!dailyForecasts.containsKey(date)) {
              dailyForecasts[date] = [];
            }
            dailyForecasts[date]!.add(item);
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Temperature Chart
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temperature Trend',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: true),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                      getTitlesWidget: (value, meta) {
                                        return Text('${value.toInt()}°C');
                                      },
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        if (value.toInt() <
                                            forecast.list.length) {
                                          final item =
                                              forecast.list[value.toInt()];
                                          final date = DateTime.parse(
                                            item.dtTxt,
                                          );
                                          return Text(
                                            DateFormat('HH:mm').format(date),
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          );
                                        }
                                        return const Text('');
                                      },
                                    ),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(show: true),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: forecast.list
                                        .take(8)
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map(
                                          (e) => FlSpot(
                                            e.key.toDouble(),
                                            e.value.main.temp,
                                          ),
                                        )
                                        .toList(),
                                    isCurved: true,
                                    color: Colors.blue,
                                    barWidth: 3,
                                    dotData: FlDotData(show: true),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Colors.blue.withOpacity(0.3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Hourly Forecast
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hourly Forecast',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            final item = forecast.list[index];
                            final dateTime = DateTime.parse(item.dtTxt);
                            return Card(
                              margin: const EdgeInsets.only(right: 8),
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('HH:mm').format(dateTime),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${item.weather[0].icon}.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                    Text(
                                      '${item.main.temp.round()}°C',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.water_drop, size: 12),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${(item.pop * 100).round()}%',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Daily Forecast
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Forecast',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dailyForecasts.length,
                        itemBuilder: (context, index) {
                          final dateKey = dailyForecasts.keys.elementAt(index);
                          final dayItems = dailyForecasts[dateKey]!;
                          final date = DateTime.parse(dateKey);

                          // Calculate daily statistics
                          final temps = dayItems
                              .map((item) => item.main.temp)
                              .toList();
                          final maxTemp = temps.reduce((a, b) => a > b ? a : b);
                          final minTemp = temps.reduce((a, b) => a < b ? a : b);
                          final mainWeather = dayItems[4].weather[0];
                          final precipitation = (dayItems[4].pop * 100).round();

                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Image.network(
                                'https://openweathermap.org/img/wn/${mainWeather.icon}@2x.png',
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                DateFormat('EEEE, MMM d').format(date),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(mainWeather.description),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.water_drop, size: 14),
                                      const SizedBox(width: 4),
                                      Text('Rain: $precipitation%'),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '↑ ${maxTemp.round()}°',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '↓ ${minTemp.round()}°',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
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
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading forecast data'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(forecastProvider(cityName));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
