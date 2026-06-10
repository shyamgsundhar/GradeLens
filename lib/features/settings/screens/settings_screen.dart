import 'package:flutter/material.dart';
import 'package:gradelens/providers/app_state.dart';
import 'package:gradelens/widgets/app_shell.dart';
import 'package:gradelens/widgets/responsive_page.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return AppShell(
      title: 'Settings',
      child: ResponsivePage(
        maxWidth: 760,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 16),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(value: ThemeMode.system, label: Text('System')),
                    ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                    ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                  ],
                  selected: {state.themeMode},
                  onSelectionChanged: (value) => state.setThemeMode(value.first),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
