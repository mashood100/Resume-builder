import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../common/strings.dart';
import '../../models/education.dart';
import '../../models/resume.dart';
import 'pdf_base_widget.dart';
import 'pdf_section_label.dart';

/// Widget for the education section
class PDFEducationSection extends PDFBaseWidget {
  PDFEducationSection({required this.resume, required this.themeColor});

  final Resume resume;
  final PdfColor themeColor;

  Widget build() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PDFSectionLabel(text: Strings.education, themeColor: themeColor).build(),
        for (final Education education in resume.visibleEducation)
          _buildEducationEntry(education)
      ],
    );
  }

  Widget _buildEducationEntry(Education education) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: themeColor, width: 2),
        ),
      ),
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                education.degreeController.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                  fontSize: 13,
                ),
              ),
              Text(
                formatDateRange(
                  education.startDateController.text,
                  education.endDateController.text,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: PdfColor(0.5, 0.5, 0.5),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                education.institutionController.text,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 11,
                ),
              ),
              Text(
                education.locationController.text,
                style: const TextStyle(
                  fontSize: 10,
                  color: PdfColor(0.5, 0.5, 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 