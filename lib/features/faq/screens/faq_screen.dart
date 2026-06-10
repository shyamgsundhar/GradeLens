import 'package:flutter/material.dart';
import 'package:gradelens/ads/adsense_banner.dart';
import 'package:gradelens/core/routes/app_router.dart';
import 'package:gradelens/core/routes/navigation_service.dart';
import 'package:gradelens/widgets/app_shell.dart';
import 'package:gradelens/widgets/responsive_page.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  static const _faqs = <({String question, String answer})>[
    (
      question: 'What is GradeLens?',
      answer:
          'GradeLens is a GPA and CGPA calculator built for students who want fast academic planning with local storage and export support.'
    ),
    (
      question: 'Is GradeLens free?',
      answer:
          'Yes. GradeLens is free to use and may be supported by advertising.'
    ),
    (
      question: 'Does GradeLens work offline?',
      answer:
          'The app is designed to be offline-first after it loads. Saved semester data is stored locally on your device.'
    ),
    (
      question: 'How is GPA calculated?',
      answer:
          'GPA is calculated by multiplying each subject grade point by its credits, adding those weighted points, and dividing by total credits.'
    ),
    (
      question: 'How is CGPA calculated?',
      answer:
          'CGPA is calculated by multiplying each semester GPA by semester credits, adding the weighted values, and dividing by total credits.'
    ),
    (
      question: 'Why does credit value matter?',
      answer:
          'Credits determine the weight of a subject or semester. Higher credit courses affect GPA and CGPA more.'
    ),
    (
      question: 'Can I save semesters?',
      answer:
          'Yes. After calculating GPA, you can save the semester locally and track cumulative CGPA.'
    ),
    (
      question: 'Can I export a report?',
      answer:
          'Yes. GradeLens supports PDF export for semester reports.'
    ),
    (
      question: 'Is my data uploaded to a server?',
      answer:
          'No. Current GradeLens semester and settings data are stored locally on your device.'
    ),
    (
      question: 'Will clearing browser data remove saved semesters?',
      answer:
          'Yes. Clearing site data, private browsing storage, or changing devices can remove locally saved semesters.'
    ),
    (
      question: 'Can I use GradeLens for official transcripts?',
      answer:
          'Use GradeLens for planning. Your university transcript and academic office remain the official source.'
    ),
    (
      question: 'Why is my result different from my college portal?',
      answer:
          'Your college may use special rules for rounding, arrears, withdrawals, pass or fail courses, or repeated attempts.'
    ),
    (
      question: 'Does GradeLens support every university?',
      answer:
          'GradeLens supports available grading schemes and can be expanded with more institution-specific scales.'
    ),
    (
      question: 'Can I calculate expected GPA before results?',
      answer:
          'Yes. Enter expected grades to estimate possible semester outcomes.'
    ),
    (
      question: 'What is a good GPA?',
      answer:
          'A good GPA depends on your university, program, scholarship rules, and career goals.'
    ),
    (
      question: 'Can a high semester GPA improve CGPA?',
      answer:
          'Yes. The impact depends on the semester credits and how many credits you have already completed.'
    ),
    (
      question: 'Should I include zero credit courses?',
      answer:
          'Only include courses that your institution counts toward GPA or CGPA.'
    ),
    (
      question: 'Should I include pass or fail subjects?',
      answer:
          'Include them only if your university assigns grade points and credits that count toward GPA.'
    ),
    (
      question: 'How can I improve GPA?',
      answer:
          'Prioritize high credit courses, complete assignments on time, practice previous papers, and review weak topics weekly.'
    ),
    (
      question: 'How often should I update CGPA?',
      answer:
          'Update CGPA after every semester result or whenever an official grade changes.'
    ),
    (
      question: 'Does GradeLens use Google AdSense?',
      answer:
          'Yes. GradeLens includes AdSense-ready ad placements on web pages, subject to Google approval and policies.'
    ),
    (
      question: 'How do I report a bug?',
      answer:
          'Use the Contact page and include the page, device, browser, steps to reproduce, and expected behavior.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'FAQ',
      child: ResponsivePage(
        maxWidth: 920,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                'Student FAQ',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Answers to common GPA, CGPA, privacy, planning, and GradeLens usage questions.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            for (var i = 0; i < _faqs.length; i++) ...[
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(_faqs[i].question),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(_faqs[i].answer),
                    ),
                  ),
                ],
              ),
              if (i == 8) const AdsenseBanner(height: 120),
            ],
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: () => NavigationService.pushNamed(AppRoutes.gpa),
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('Calculate GPA'),
                ),
                OutlinedButton.icon(
                  onPressed: () => NavigationService.pushNamed(AppRoutes.contact),
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Contact support'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
