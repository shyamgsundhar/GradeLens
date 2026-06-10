import 'dart:typed_data';

import 'package:gradelens/core/constants/app_constants.dart';
import 'package:gradelens/core/utils/formatters.dart';
import 'package:gradelens/models/semester_model.dart';
import 'package:gradelens/services/calculation_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfExportService {
  const PdfExportService();

  Future<void> downloadSemesterReport({
    required SemesterModel semester,
    required CgpaResult cgpa,
  }) async {
    final bytes = await _buildReport(semester: semester, cgpa: cgpa);
    final safeName = semester.semesterName.toLowerCase().replaceAll(' ', '-');
    await Printing.sharePdf(bytes: bytes, filename: 'gradelens-$safeName.pdf');
  }

  Future<Uint8List> _buildReport({
    required SemesterModel semester,
    required CgpaResult cgpa,
  }) async {
    final regularFont = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();
    final document = pw.Document();

    document.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(32),
          theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
        ),
        footer: (_) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Generated using GradeLens',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
        ),
        build: (context) => [
          _header(),
          pw.SizedBox(height: 28),
          pw.Text(
            semester.semesterName,
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text('University: ${semester.universityName}'),
          pw.Text('Created: ${Formatters.date(semester.createdAt)}'),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blue50),
            headers: const ['Subject', 'Grade', 'Credits', 'Point', 'Weighted'],
            data: semester.subjects
                .map(
                  (subject) => [
                    subject.subjectName,
                    subject.grade,
                    subject.credits.toString(),
                    Formatters.score(subject.gradePoint),
                    Formatters.score(subject.weightedPoints),
                  ],
                )
                .toList(),
          ),
          pw.SizedBox(height: 24),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _metric('GPA', Formatters.score(semester.gpa)),
              _metric('CGPA', Formatters.score(cgpa.cgpa)),
              _metric('Credits', semester.credits.toString()),
            ],
          ),
        ],
      ),
    );

    return document.save();
  }

  pw.Widget _header() {
    return pw.Row(
      children: [
        pw.Container(
          width: 42,
          height: 42,
          decoration: pw.BoxDecoration(
            color: PdfColors.blue700,
            borderRadius: pw.BorderRadius.circular(8),
          ),
          alignment: pw.Alignment.center,
          child: pw.Text(
            'GL',
            style: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.SizedBox(width: 12),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              AppConstants.appName,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(AppConstants.websiteUrl),
          ],
        ),
      ],
    );
  }

  pw.Widget _metric(String label, String value) {
    return pw.Container(
      width: 150,
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: const pw.TextStyle(color: PdfColors.grey700)),
          pw.SizedBox(height: 6),
          pw.Text(
            value,
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
