import 'dart:typed_data';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../common/strings.dart';
import '../data/models/resume.dart';
import 'widgets/pdf_widgets.dart';

/// Generates a PDF from a [Resume].
class PDFGenerator {
  PDFGenerator({required this.resume});

  /// The resume to be generated as PDF.
  Resume resume;

  /// Converts Flutter Color to PDF Color
  PdfColor _flutterColorToPdfColor(cupertino.Color color) {
    return PdfColor(
      color.red / 255,
      color.green / 255,
      color.blue / 255,
      color.alpha / 255,
    );
  }

  /// Gets the theme color or defaults to a blue shade
  PdfColor get themeColor {
    if (resume.themeColor != null) {
      return _flutterColorToPdfColor(resume.themeColor!);
    }
    // Default theme color
    return const PdfColor(0.2, 0.4, 0.6);
  }

  /// The sections of the resume in the order they should be displayed.
  List<Widget> _getOrderedSections() {
    final List<Widget> sections = <Widget>[];

    for (final String sectionName in resume.sectionOrder) {
      if (!resume.sectionVisible(sectionName)) {
        continue;
      }

      switch (sectionName) {
        case Strings.skills:
          sections.add(
              PDFSkillsSection(resume: resume, themeColor: themeColor).build());
        case Strings.experience:
          sections.add(
              PDFExperienceSection(resume: resume, themeColor: themeColor)
                  .build());
        case Strings.education:
          sections.add(
              PDFEducationSection(resume: resume, themeColor: themeColor)
                  .build());
        default:
          sections.add(PDFCustomSection(
                  resume: resume,
                  themeColor: themeColor,
                  sectionName: sectionName)
              .build());
      }
    }

    return sections;
  }

  /// Generates the resume as a PDF.
  Future<Uint8List> generateResumeAsPDF() async {
    final Document pdf = Document();

    pdf.addPage(
      MultiPage(
        theme: ThemeData.withFont(
          base: await PdfGoogleFonts.notoSansRegular(),
          bold: await PdfGoogleFonts.notoSansBold(),
          italic: await PdfGoogleFonts.notoSansItalic(),
          boldItalic: await PdfGoogleFonts.notoSansBoldItalic(),
          icons: await PdfGoogleFonts.cupertinoIcons(),
        ),
        pageFormat: PdfPageFormat.letter,
        margin: const EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 25),
        header: (Context context) {
          if (context.pageNumber == 1) {
            return PDFHeader(resume: resume, themeColor: themeColor).build();
          }
          return Container();
        },
        build: (Context context) => _getOrderedSections(),
        footer: (Context context) => PDFFooter(
          resume: resume,
          currentPage: context.pageNumber,
          totalPages: context.pagesCount,
        ).build(),
      ),
    );
    return pdf.save();
  }
}
