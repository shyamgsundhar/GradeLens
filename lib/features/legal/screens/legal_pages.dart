import 'package:flutter/widgets.dart';
import 'package:gradelens/features/content/screens/article_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'About GradeLens',
        description:
            'GradeLens is a student-friendly GPA and CGPA platform built for quick academic planning.',
        sections: [
          ArticleSection(
            title: 'What GradeLens Is',
            paragraphs: [
              'GradeLens helps students calculate semester GPA, save semesters, and track cumulative CGPA from one simple interface. It was created for students who want a fast, clear, and private way to understand academic progress without spreadsheets or account setup.',
              'The platform focuses on practical academic planning. You can select a grading system, enter subjects and credits, calculate GPA, export reports, and save completed semesters for CGPA tracking.',
            ],
          ),
          ArticleSection(
            title: 'Why It Was Created',
            paragraphs: [
              'Students often need to estimate outcomes before official results are published. GradeLens turns grade planning into a guided workflow so students can understand how credits, grade points, and semester results connect.',
              'The mission is to make academic planning accessible, transparent, and low-friction. A student should be able to open the app, calculate a result, and make a better study decision in minutes.',
            ],
          ),
          ArticleSection(
            title: 'Student Benefits',
            paragraphs: [
              'GradeLens is offline-first, stores semester data locally, supports GPA and CGPA tracking, and provides educational guides for students who want to understand the formulas behind the results.',
              'Future planning features can build on this foundation with analytics, goal setting, reminders, and institution-specific grading support.',
            ],
          ),
        ],
      );
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'Privacy Policy',
        description:
            'How GradeLens handles local storage, cookies, third-party services, and student data.',
        sections: [
          ArticleSection(
            title: 'Local Storage',
            paragraphs: [
              'GradeLens stores saved semesters and app preferences locally on your device. This allows the app to work quickly and preserve your GPA and CGPA history without requiring an account.',
              'Local data may include semester names, university names, subject names, grades, credits, calculated GPA values, and theme preferences. This information remains in your browser or device storage unless you clear it.',
            ],
          ),
          ArticleSection(
            title: 'Cookies and Advertising',
            paragraphs: [
              'GradeLens may display advertising through Google AdSense. Google and its partners may use cookies or similar technologies to serve ads, measure performance, prevent abuse, and personalize advertising where permitted by law.',
              'You can manage cookie and ad personalization settings through your browser and Google account controls. AdSense is a third-party service and is governed by Google policies in addition to this policy.',
            ],
          ),
          ArticleSection(
            title: 'Third-Party Services',
            paragraphs: [
              'The website may use third-party services such as Google AdSense, future analytics, hosting providers, and search engine tools. These services may process technical information such as browser type, device information, approximate location, referral pages, and interaction events.',
              'GradeLens does not sell personal academic data. Future analytics integrations should use privacy-conscious configuration and should not require students to submit personal identifiers.',
            ],
          ),
          ArticleSection(
            title: 'Contact',
            paragraphs: [
              'For privacy questions, feedback, or data handling concerns, contact the GradeLens maintainer at support@gradelens.example. Replace this placeholder with the production support email before launch.',
            ],
          ),
        ],
      );
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'Contact',
        description:
            'Reach the GradeLens team for support, feedback, and bug reports.',
        sections: [
          ArticleSection(
            title: 'Support',
            paragraphs: [
              'For help using GradeLens, email support@gradelens.example. Include your browser, device type, and a short description of what you were trying to do.',
              'If your question is about an official transcript, grading dispute, scholarship, or university rule, contact your institution first. GradeLens is an educational planning tool and cannot replace official academic guidance.',
            ],
          ),
          ArticleSection(
            title: 'Feedback',
            paragraphs: [
              'Student feedback helps improve the calculator, guide pages, accessibility, and future planning features. Share feature ideas, confusing wording, missing grading systems, or suggestions for academic resources.',
            ],
          ),
          ArticleSection(
            title: 'Bug Reports',
            paragraphs: [
              'When reporting a bug, include the page, steps to reproduce the issue, expected behavior, actual behavior, and whether the problem happens after refreshing the page. Screenshots are helpful when layout or mobile behavior is involved.',
            ],
          ),
        ],
      );
}

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'Terms & Conditions',
        description:
            'Usage terms, educational disclaimers, and responsibilities for GradeLens users.',
        sections: [
          ArticleSection(
            title: 'Educational Use',
            paragraphs: [
              'GradeLens is provided as an educational calculator and academic planning tool. It helps estimate GPA and CGPA based on user-entered grades, credits, and selected grading systems.',
              'The app does not issue official grades, transcripts, certificates, eligibility decisions, or academic approvals. Always rely on your institution for official academic records.',
            ],
          ),
          ArticleSection(
            title: 'Accuracy Disclaimer',
            paragraphs: [
              'GradeLens aims to provide accurate calculations using common weighted GPA and CGPA formulas. However, university policies can vary for repeated courses, withdrawals, pass or fail subjects, arrears, transfer credits, and rounding.',
              'Users are responsible for verifying inputs, grade scales, credit values, and institutional rules before relying on calculated results for important decisions.',
            ],
          ),
          ArticleSection(
            title: 'User Responsibilities',
            paragraphs: [
              'Use GradeLens lawfully and responsibly. Do not attempt to interfere with the website, misuse advertising systems, or present estimated results as official university records.',
              'You are responsible for preserving any local data you need. Clearing browser storage, changing devices, or using private browsing may remove saved semesters.',
            ],
          ),
          ArticleSection(
            title: 'Limitation of Liability',
            paragraphs: [
              'GradeLens is provided without warranties. The maintainers are not liable for academic, financial, professional, or personal decisions made using estimated results from the app.',
            ],
          ),
        ],
      );
}
