import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../common/strings.dart';
import '../../data/models/resume.dart';
import 'pdf_base_widget.dart';
import 'pdf_section_label.dart';

/// Widget for the skills section
class PDFSkillsSection extends PDFBaseWidget {
  PDFSkillsSection({required this.resume, required this.themeColor});

  final Resume resume;
  final PdfColor themeColor;

  Widget build() {
    return resume.skillTextControllers.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                PDFSectionLabel(text: Strings.skills, themeColor: themeColor).build(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: const PdfColor(0.95, 0.95, 0.95),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: <Widget>[
                      for (int iterator = 0;
                          iterator < resume.skillTextControllers.length;
                          iterator++)
                        if (resume
                            .skillTextControllers[iterator].text.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: PdfColor(1, 1, 1),
                              border: Border.all(
                                  color: PdfColor(0.7, 0.7, 0.7), width: 0.5),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              resume.skillTextControllers[iterator].text,
                              style: const TextStyle(fontSize: 10),
                            ),
                          )
                    ],
                  ),
                ),
                SizedBox(height: 8),
              ]);
  }
} 