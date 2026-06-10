import 'package:flutter/widgets.dart';
import 'package:gradelens/features/content/screens/article_page.dart';

class HowGpaIsCalculatedPage extends StatelessWidget {
  const HowGpaIsCalculatedPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'How GPA Is Calculated',
        description:
            'Learn the GPA formula, how credits affect your score, and how to avoid common calculation mistakes.',
        sections: [
          ArticleSection(
            title: 'What GPA Measures',
            paragraphs: [
              'Grade Point Average, usually shortened to GPA, is a weighted summary of your academic performance in a semester or study period. A GPA is not simply an average of letter grades. It combines the grade point earned in each subject with the credit value of that subject, which means a four credit course usually affects the final result more than a one credit lab or seminar.',
              'Most universities publish a grade table that converts grades such as O, A+, A, B+, B, or C into numeric grade points. GradeLens follows that idea: you select the grading system, enter each subject, choose the grade, and enter credits. The calculator then multiplies every grade point by the credits for that subject and divides the total weighted points by total credits.',
              'This weighted method is important for planning because it shows where effort matters most. Improving a high credit subject can move a semester GPA more than improving a low credit subject by the same grade step. Students who understand this can plan study time more realistically and avoid being surprised after results are published.',
            ],
          ),
          ArticleSection(
            title: 'GPA Formula',
            paragraphs: [
              'The standard formula is GPA = total weighted grade points divided by total credits. Weighted grade points are calculated by multiplying each subject grade point by that subject credit value. For example, if Mathematics is 4 credits and the grade point is 10, it contributes 40 weighted points.',
              'A complete example might look like this: Mathematics, 4 credits, grade point 10, contributes 40. Physics, 3 credits, grade point 8, contributes 24. Programming, 4 credits, grade point 9, contributes 36. English, 2 credits, grade point 8, contributes 16. Total weighted points are 116 and total credits are 13, so GPA is 116 / 13 = 8.92.',
              'The formula can be written as the sum of grade point times credit for every subject, divided by the sum of all credits. This is why credits should never be ignored. A simple average of 10, 8, 9, and 8 would give 8.75, but the correct weighted GPA is 8.92 because the higher scoring subjects carry more credits.',
            ],
          ),
          ArticleSection(
            title: 'Common Mistakes',
            paragraphs: [
              'The most common mistake is averaging grades without credits. Another mistake is using the wrong university grade scale. Some institutions use a 10 point scale, some use a 4 point scale, and some assign different point values to similar letter grades. Always verify the official scale before using the result for scholarship, placement, or academic eligibility decisions.',
              'Students also sometimes include audit courses, pass or fail courses, withdrawn courses, or zero credit activities that should not be part of GPA. Policies vary, so the safest approach is to compare the calculator inputs with your official semester mark sheet or academic handbook.',
              'Rounding is another source of confusion. A department may round to two decimal places, while a portal may store more precision internally. GradeLens displays a student-friendly score, but official transcripts may apply their own formatting rule.',
            ],
          ),
          ArticleSection(
            title: 'Using GPA for Planning',
            paragraphs: [
              'GPA is most useful when it becomes a planning tool instead of only a result. Before exams, enter realistic target grades and credits to estimate your semester outcome. Then adjust the targets to see which subjects have the highest impact. This helps you focus on the combination of effort and credit weight that can change your final number.',
              'A strong planning routine is to create three scenarios: conservative, expected, and stretch. The conservative scenario shows the outcome if difficult subjects land one grade lower than hoped. The expected scenario reflects your current preparation. The stretch scenario shows what happens if you improve the highest credit courses. Together, these scenarios make academic goals feel concrete.',
              'For deeper planning, write down the reason behind each expected grade. If you expect an A in a subject because internal marks are strong and the final syllabus is manageable, the estimate is more reliable. If you expect the same grade only because you need it, the plan may be too optimistic. GPA planning works best when every grade target has evidence behind it.',
              'It is also useful to separate controllable and less controllable factors. Attendance, assignment submission, lab record completion, revision hours, and doubt clearing are controllable. Exam difficulty and strict evaluation are less controllable. A good plan gives extra margin in important courses so one difficult paper does not destroy the entire semester target.',
            ],
          ),
          ArticleSection(
            title: 'Detailed Worked Example',
            paragraphs: [
              'Consider a semester with five subjects: Data Structures for 4 credits with grade point 9, Mathematics for 4 credits with grade point 8, Physics for 3 credits with grade point 8, English for 2 credits with grade point 10, and Lab for 1 credit with grade point 10. The weighted points are 36, 32, 24, 20, and 10. The total is 122 weighted points over 14 credits, so the GPA is 8.71.',
              'Now imagine the student wants to raise the GPA above 9.0. Improving the 1 credit lab from 10 to 10 is impossible because it is already at the top. Improving English from 10 to 10 also adds nothing. Improving Mathematics from 8 to 9 adds 4 weighted points, and improving Data Structures from 9 to 10 adds 4 weighted points. Together they move the total to 130, creating a GPA of 9.29. This shows why high credit courses deserve careful attention.',
              'The lesson is not that small courses are unimportant. Small courses can protect grade boundaries and may be required for completion. The lesson is that GPA movement comes from weighted impact. A student who understands the impact can study with clarity instead of spreading effort randomly across all subjects at the same intensity.',
            ],
          ),
          ArticleSection(
            title: 'Summary',
            paragraphs: [
              'GPA is a weighted credit based average. The correct calculation multiplies grade points by credits, adds the weighted points, and divides by total credits. Use the official grade table, avoid including courses that do not count, and treat GPA as a planning signal for the next semester.',
            ],
          ),
        ],
        faqs: [
          (
            question: 'Is GPA the same as percentage?',
            answer:
                'No. GPA is based on grade points and credits. Percentage is usually based on raw marks. Conversion rules depend on the institution.'
          ),
          (
            question: 'Do credits really matter?',
            answer:
                'Yes. Higher credit courses carry more weight in the final GPA calculation.'
          ),
          (
            question: 'Can I calculate GPA before final results?',
            answer:
                'Yes. You can enter expected grades to estimate possible outcomes and plan your study priorities.'
          ),
        ],
      );
}

class HowCgpaIsCalculatedPage extends StatelessWidget {
  const HowCgpaIsCalculatedPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'How CGPA Is Calculated',
        description:
            'Understand cumulative GPA, semester credits, weighted averages, and long-term academic tracking.',
        sections: [
          ArticleSection(
            title: 'What CGPA Means',
            paragraphs: [
              'Cumulative Grade Point Average, or CGPA, summarizes performance across multiple semesters. While GPA usually describes one semester, CGPA combines all completed semesters into one long-term academic score. It helps students, departments, scholarship committees, and recruiters understand performance across time rather than in a single exam cycle.',
              'The key idea is that CGPA should respect semester credits. If one semester has 24 credits and another has 18 credits, the 24 credit semester normally contributes more to the cumulative result. A simple average of semester GPAs can be misleading when credit loads differ.',
              'GradeLens stores saved semesters locally and calculates CGPA from the GPA and credit value of each saved semester. This makes the tracker useful even when you study under changing semester loads or when labs, projects, and electives create uneven credits.',
            ],
          ),
          ArticleSection(
            title: 'CGPA Formula',
            paragraphs: [
              'The usual formula is CGPA = sum of semester GPA times semester credits divided by sum of semester credits. If Semester 1 has GPA 8.6 with 22 credits, it contributes 189.2 weighted points. If Semester 2 has GPA 9.1 with 20 credits, it contributes 182 weighted points. Total weighted points are 371.2 and total credits are 42, so CGPA is 8.84.',
              'This method gives each credit equal importance across the degree. It prevents a light semester from affecting the cumulative score as much as a heavy semester. It also makes improvement planning more accurate because future high credit semesters can shift the cumulative score more than low credit semesters.',
              'Some universities calculate CGPA directly from every subject across all semesters, which reaches the same result when each semester GPA was calculated correctly from credits. The semester based method is convenient because students can save one completed term at a time.',
            ],
          ),
          ArticleSection(
            title: 'Academic Use Cases',
            paragraphs: [
              'CGPA is often used for placement eligibility, scholarships, honors lists, exchange programs, postgraduate applications, and academic probation checks. Because of that, students should track it regularly rather than waiting until the final year. A small early dip can be repaired more easily when there are many credits left.',
              'For planning, estimate future semester GPAs and credits to see what CGPA is possible by graduation. If your current CGPA is 7.8 and you need 8.0, the required future GPA depends on how many credits remain. This is a weighted target problem, not a guess.',
              'GradeLens is designed for this habit: calculate a semester GPA, save it, then review the cumulative result. Since saved data stays local, it is fast and available without account setup.',
              'CGPA is also helpful for deciding whether to repeat an exam where improvement is allowed. If a repeated high credit course can replace an old low grade, the cumulative impact may be meaningful. If the course has low credits or the university averages attempts, the benefit may be smaller. Always compare the policy with a weighted calculation before committing time and fees.',
              'Students applying for internships can use CGPA tracking to prepare honest academic summaries. Instead of guessing whether a target is reachable by placement season, they can model remaining semesters and understand what average GPA is needed. This makes conversations with mentors, parents, and faculty advisors more concrete.',
            ],
          ),
          ArticleSection(
            title: 'Detailed Worked Example',
            paragraphs: [
              'Suppose a student has four completed semesters. Semester 1 is 8.0 with 20 credits, Semester 2 is 8.4 with 21 credits, Semester 3 is 7.9 with 19 credits, and Semester 4 is 9.0 with 22 credits. The weighted points are 160, 176.4, 150.1, and 198. Total weighted points are 684.5 across 82 credits. The CGPA is 8.35.',
              'If the student simply averages 8.0, 8.4, 7.9, and 9.0, the result is 8.33. That looks close in this example, but it is close only by coincidence. When credit differences are larger, the simple average can drift more. Weighted CGPA is the safer method because it respects the academic value assigned to each semester.',
              'For future planning, assume the student has two semesters left with 22 credits each and wants to finish above 8.5. The current weighted total is 684.5. A final CGPA of 8.5 over 126 total credits requires 1071 weighted points. The student needs 386.5 weighted points across 44 remaining credits, which means an average future GPA of about 8.78. That target is much clearer than simply hoping the CGPA rises.',
            ],
          ),
          ArticleSection(
            title: 'Mistakes to Avoid',
            paragraphs: [
              'Do not average semester GPAs unless all semesters have exactly the same credit load and your institution permits that shortcut. Do not mix different grading scales without conversion. Do not include repeated courses twice unless your university policy counts both attempts.',
              'Also remember that official transcripts may apply special rules for arrears, withdrawals, improvement exams, transfer credits, and pass or fail requirements. A calculator is a planning tool; your university record remains the final authority.',
            ],
          ),
          ArticleSection(
            title: 'Summary',
            paragraphs: [
              'CGPA is a weighted cumulative score across semesters. Multiply every semester GPA by its credits, add the results, and divide by total credits. Track it early, plan future targets, and use official rules for high-stakes decisions.',
            ],
          ),
        ],
        faqs: [
          (
            question: 'Why is my CGPA not the average of my GPAs?',
            answer:
                'Different semester credit loads change the weighting, so the cumulative score may differ from a simple average.'
          ),
          (
            question: 'Can one semester improve CGPA significantly?',
            answer:
                'Yes, especially when it has many credits or when you still have several semesters left.'
          ),
          (
            question: 'Does GradeLens save CGPA online?',
            answer:
                'No. GradeLens stores saved semesters locally on your device.'
          ),
        ],
      );
}

class GpaVsCgpaPage extends StatelessWidget {
  const GpaVsCgpaPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'GPA vs CGPA',
        description:
            'A practical comparison of semester GPA and cumulative CGPA for academic planning.',
        sections: [
          ArticleSection(
            title: 'The Difference',
            paragraphs: [
              'GPA and CGPA are related, but they answer different questions. GPA usually answers, “How did I perform this semester?” CGPA answers, “How am I performing across the entire program so far?” A semester GPA is short-term and sensitive to recent work. CGPA is long-term and changes more gradually as completed credits accumulate.',
              'For example, a student may earn a 9.4 GPA in the third semester after earning 7.8 and 8.1 in earlier semesters. The third semester result shows strong improvement, but the CGPA will sit somewhere between the old and new performance levels because it includes all credits completed so far.',
              'Both numbers matter. GPA helps you review current habits, course difficulty, and exam preparation. CGPA helps you understand eligibility, graduation standing, and long-term progress.',
            ],
          ),
          ArticleSection(
            title: 'When GPA Matters Most',
            paragraphs: [
              'GPA matters most for semester level evaluation. It can show whether a new study routine worked, whether a course load was too heavy, or whether a particular grading system affected the outcome. Faculty advisors may use semester GPA to identify recent improvement or recent difficulty.',
              'Students should use GPA immediately after each assessment period. If your GPA falls below your target, review the highest credit courses, identify weak preparation patterns, and make changes before the next semester. Waiting until CGPA falls can make recovery harder.',
              'GPA is also helpful for short-term goals such as qualifying for a department list, meeting a semester scholarship condition, or assessing whether to reduce extracurricular commitments during a demanding term.',
            ],
          ),
          ArticleSection(
            title: 'When CGPA Matters Most',
            paragraphs: [
              'CGPA matters most for cumulative academic decisions. Campus placements, internships, postgraduate applications, exchange programs, and scholarships often use CGPA because it reflects sustained performance. A single excellent GPA is encouraging, but CGPA shows whether performance has been consistent across many credits.',
              'Because CGPA changes slowly later in a degree, early planning is powerful. A first-year student has many credits remaining, so improvement can move the cumulative score substantially. A final-year student has fewer credits remaining, so each semester has less room to repair earlier results.',
              'GradeLens supports both perspectives by letting you calculate the current GPA and then save it into the CGPA tracker.',
              'CGPA is also useful when comparing academic progress across years. A student who moves from 7.6 to 8.2 over several semesters is building a stronger long-term record even if one individual semester is not perfect. Recruiters and academic committees often appreciate consistency and improvement, especially when the transcript shows stronger performance in advanced subjects.',
              'At the same time, students should not ignore GPA because CGPA is the headline number. A falling semester GPA can be an early warning signal. It may show that course difficulty increased, study habits need adjustment, or personal workload is too high. Acting on the GPA signal early protects the CGPA later.',
            ],
          ),
          ArticleSection(
            title: 'How to Use Both Together',
            paragraphs: [
              'A practical routine is to review GPA first and CGPA second. After each semester, ask what the GPA says about recent performance. Which subjects helped? Which subjects pulled the result down? Were the weak areas caused by concept gaps, time pressure, missed internal marks, or exam strategy? This turns GPA into feedback rather than judgment.',
              'Then review CGPA to understand long-term direction. If CGPA is already above your target, the goal may be to maintain consistency and avoid preventable drops. If CGPA is below your target, calculate the future average needed across remaining credits. That number can guide course selection, study intensity, and academic support decisions.',
              'Students can also use both metrics for communication. GPA is useful when discussing the latest semester with a mentor. CGPA is useful when filling forms, preparing resumes, or checking eligibility. Keeping both numbers current prevents last-minute confusion during applications.',
            ],
          ),
          ArticleSection(
            title: 'Example Comparison',
            paragraphs: [
              'Imagine three semesters: 8.0 GPA with 20 credits, 8.5 GPA with 22 credits, and 9.2 GPA with 18 credits. The latest GPA is 9.2, which describes the third semester. The CGPA is calculated from all weighted semester points: 160 + 187 + 165.6 = 512.6 weighted points over 60 credits. CGPA is 8.54.',
              'This example shows why students should not be discouraged if CGPA rises slowly. The newer 9.2 GPA is excellent, but previous credits still count. Consistency over multiple semesters is what steadily lifts the cumulative number.',
            ],
          ),
          ArticleSection(
            title: 'Summary',
            paragraphs: [
              'Use GPA for semester reflection and immediate planning. Use CGPA for long-term eligibility and graduation progress. The strongest academic planning habit is to monitor both after every semester.',
            ],
          ),
        ],
        faqs: [
          (
            question: 'Which is more important?',
            answer:
                'CGPA is usually more important for cumulative eligibility, while GPA is more useful for recent performance review.'
          ),
          (
            question: 'Can a high GPA raise a low CGPA?',
            answer:
                'Yes, but the amount depends on remaining credits and past completed credits.'
          ),
          (
            question: 'Should I mention GPA or CGPA on a resume?',
            answer:
                'Use the metric requested by the employer or institution, and follow your university transcript terminology.'
          ),
        ],
      );
}

class SemesterPlanningPage extends StatelessWidget {
  const SemesterPlanningPage({super.key});

  @override
  Widget build(BuildContext context) => const ArticlePage(
        title: 'Semester Planning Guide',
        description:
            'Plan credits, study time, GPA targets, and academic goals before the semester becomes stressful.',
        sections: [
          ArticleSection(
            title: 'Start With Credits',
            paragraphs: [
              'A useful semester plan begins with the credit table. Credits show how much each course can affect GPA, but they also hint at workload. High credit theory subjects often need repeated practice, while labs and projects may need steady weekly progress. Before classes become busy, list every subject, credit value, assessment pattern, and expected difficulty.',
              'Once the credit map is visible, divide subjects into impact levels. High credit and high difficulty subjects deserve the earliest attention. Low credit subjects still matter, but they should not consume all study time if a major course is at risk. This is not about ignoring any subject; it is about matching effort to academic impact.',
              'GradeLens can help by letting you test target grades before results. Try entering expected grades, then improve one subject at a time to see which changes matter most.',
            ],
          ),
          ArticleSection(
            title: 'Set GPA Targets',
            paragraphs: [
              'A semester target should be specific and realistic. Instead of saying, “I want a good GPA,” choose a target such as 8.5 or 9.0 and then translate it into subject grade targets. This makes the goal actionable. You may discover that one difficult course can be one grade lower if two other courses are strong, or that a high credit course must be protected.',
              'Create three plans: minimum acceptable, expected, and ambitious. The minimum plan tells you what must happen to stay eligible. The expected plan reflects current preparation. The ambitious plan shows what focused improvement can achieve. Reviewing these scenarios reduces anxiety because you know the path instead of chasing a vague number.',
              'Update the plan after internal assessments, assignments, or mid-semester exams. A plan that changes with evidence is more useful than a perfect plan that becomes outdated.',
            ],
          ),
          ArticleSection(
            title: 'Build Weekly Study Rhythm',
            paragraphs: [
              'Academic improvement is usually a rhythm problem. Students often overestimate what can be done right before exams and underestimate what weekly practice can do. Reserve regular time for high credit subjects, quick review sessions for memory-heavy courses, and project blocks for work that cannot be rushed.',
              'Use short feedback loops. After each week, ask which subject is becoming unclear, which assignment is slipping, and which exam topics need practice. Small corrections prevent the final month from becoming overloaded.',
              'A good weekly rhythm also includes rest. Burnout reduces recall, problem solving, and consistency. Sustainable study plans leave space for meals, sleep, exercise, and recovery.',
              'One useful method is to schedule fixed review blocks for high credit subjects and flexible catch-up blocks for smaller tasks. Fixed blocks protect the courses that drive GPA. Flexible blocks absorb unexpected assignments, lab corrections, group project meetings, or revision delays. This prevents one surprise task from breaking the entire week.',
              'Another helpful habit is a weekly grade-risk review. Mark each subject green, yellow, or red. Green means current work is on track. Yellow means one topic, assignment, or assessment needs attention. Red means the subject can damage the semester target if no action is taken. This simple review keeps planning visible.',
            ],
          ),
          ArticleSection(
            title: 'Credit Management and Goal Setting',
            paragraphs: [
              'Credit management is not only about calculating GPA. It is about understanding workload before it becomes overwhelming. If a semester contains several high credit technical subjects, a major project, and lab work, the plan should begin earlier than usual. Heavy semesters need smaller weekly milestones because waiting until exam month creates too much pressure.',
              'Academic goal setting should connect long-term CGPA targets with short-term actions. If you need an 8.7 semester GPA to stay on track, translate that number into expected grades for each course. Then translate those grades into weekly tasks: problem sets completed, chapters revised, lab work finished, previous papers solved, and doubts clarified.',
              'A good goal is measurable but humane. Students are not machines, and every semester includes uncertainty. Build buffer into the plan, protect sleep, and seek help early. Strong academic planning is not about anxiety; it is about making the next useful action obvious.',
            ],
          ),
          ArticleSection(
            title: 'Improve GPA Strategically',
            paragraphs: [
              'To improve GPA, focus first on preventable losses: missed assignments, late submissions, incomplete lab records, and weak attendance requirements. These are often easier to fix than final exam performance and can protect grade boundaries.',
              'Next, invest in high impact courses. Practice previous papers, solve graded examples, discuss doubts early, and build summary notes. For numerical subjects, repeated problem solving matters. For theory subjects, active recall and structured answers matter. For projects, progress logs and early demos reduce last-minute risk.',
              'Finally, review results honestly. If a subject went poorly, identify whether the cause was concept gaps, time management, exam strategy, or health. The solution depends on the cause.',
            ],
          ),
          ArticleSection(
            title: 'Summary',
            paragraphs: [
              'Semester planning works best when credits, targets, weekly habits, and feedback loops connect. Use GradeLens to model outcomes, then use the model to make better study decisions before grades are final.',
            ],
          ),
        ],
        faqs: [
          (
            question: 'How often should I recalculate targets?',
            answer:
                'Recalculate after major internal marks, project reviews, or whenever your expected grade changes.'
          ),
          (
            question: 'Should I study only high credit subjects?',
            answer:
                'No. High credit subjects need priority, but low credit courses can still affect GPA and completion requirements.'
          ),
          (
            question: 'What is the best GPA improvement strategy?',
            answer:
                'Protect high credit courses, avoid preventable assignment losses, and review weak topics every week.'
          ),
        ],
      );
}
