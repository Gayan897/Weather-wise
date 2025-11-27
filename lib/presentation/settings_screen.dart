// lib/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/presentation/providers/weather_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temperatureUnit = ref.watch(temperatureUnitProvider);
    final isDarkMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Theme Section
          _SectionHeader(title: 'Appearance'),
          SwitchListTile(
            secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: isDarkMode,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).state = value;
            },
          ),
          const Divider(),

          // Units Section
          _SectionHeader(title: 'Units'),
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text('Temperature Unit'),
            subtitle: Text(
              temperatureUnit == 'metric' ? 'Celsius (°C)' : 'Fahrenheit (°F)',
            ),
            trailing: DropdownButton<String>(
              value: temperatureUnit,
              items: const [
                DropdownMenuItem(value: 'metric', child: Text('Celsius')),
                DropdownMenuItem(value: 'imperial', child: Text('Fahrenheit')),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(temperatureUnitProvider.notifier).state = value;
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.air),
            title: const Text('Wind Speed Unit'),
            subtitle: const Text('m/s (meters per second)'),
            trailing: DropdownButton<String>(
              value: 'm/s',
              items: const [
                DropdownMenuItem(value: 'm/s', child: Text('m/s')),
                DropdownMenuItem(value: 'km/h', child: Text('km/h')),
                DropdownMenuItem(value: 'mph', child: Text('mph')),
              ],
              onChanged: (value) {
                // Implement wind speed unit change
              },
            ),
          ),
          const Divider(),

          // Notifications Section
          _SectionHeader(title: 'Notifications'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Weather Alerts'),
            subtitle: const Text('Receive severe weather notifications'),
            value: true,
            onChanged: (value) {
              // Implement notification toggle
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.schedule),
            title: const Text('Daily Forecast'),
            subtitle: const Text('Daily weather summary at 8:00 AM'),
            value: false,
            onChanged: (value) {
              // Implement daily forecast toggle
            },
          ),
          const Divider(),

          // Location Section
          _SectionHeader(title: 'Location'),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Use Current Location'),
            subtitle: const Text('Automatically detect your location'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to location settings
            },
          ),
          const Divider(),

          // Data & Privacy Section
          _SectionHeader(title: 'Data & Privacy'),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Clear Cache'),
            subtitle: const Text('Remove cached weather data'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Cache'),
                  content: const Text(
                    'This will remove all cached weather data. Continue?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
              if (confirm == true && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cache cleared successfully')),
                );
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Show privacy policy
            },
          ),
          const Divider(),

          // About Section
          _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Weather Wise'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Weather Wise',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.cloud, size: 48),
                children: [
                  const Text(
                    'A comprehensive weather application built with Flutter.',
                  ),
                  const SizedBox(height: 16),
                  const Text('Data provided by OpenWeatherMap API'),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('Rate This App'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Open app store rating
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Send Feedback'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Open feedback form
            },
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              '© 2025 Weather Wise',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
