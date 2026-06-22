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
        child: SingleChildScrollView(
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
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text('System'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text('Light'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text('Dark'),
                      ),
                    ],
                    selected: {state.themeMode},
                    onSelectionChanged: (value) =>
                        state.setThemeMode(value.first),
                  ),

                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 16),

                  Text(
                    'CGPA Calculation Rules',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),

                  const SizedBox(height: 16),

                  _buildRule(
                    context,
                    'Include only CGPA-eligible courses:',
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• Theory'),
                        Text('• Theory with Lab'),
                        Text('• Laboratory Courses'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _buildRule(
                    context,
                    'Exclude the following courses:',
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• Mandatory Non-Credit Courses'),
                        Text('• NPTEL Courses'),
                        Text('• Global Certifications'),
                        Text('• Liberal Arts Courses'),
                        Text('• Industry One-Credit Courses'),
                        Text('• Value Added Courses'),
                        Text('• Language Courses'),
                        Text('• Any other non-CGPA courses'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _buildRule(
                    context,
                    'Arrears / Backlogs (RA) are not counted in CGPA calculations.',
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Anna University Grade Points',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  const SizedBox(height: 8),

                  const Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text('O = 10')),
                      Chip(label: Text('A+ = 9')),
                      Chip(label: Text('A = 8')),
                      Chip(label: Text('B+ = 7')),
                      Chip(label: Text('B = 6')),
                      Chip(label: Text('C = 5')),
                      Chip(label: Text('RA = 0')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildRule(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
