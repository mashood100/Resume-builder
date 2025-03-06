import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../common/strings.dart';
import '../../data/models/experience.dart';
import '../../data/models/resume.dart';
import 'pdf_base_widget.dart';
import 'pdf_section_label.dart';

/// Widget for the experience section
class PDFExperienceSection extends PDFBaseWidget {
  PDFExperienceSection({required this.resume, required this.themeColor});

  final Resume resume;
  final PdfColor themeColor;

  Widget build() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PDFSectionLabel(text: Strings.experience, themeColor: themeColor).build(),
        for (final Experience experience in resume.visibleExperiences)
          _buildExperienceEntry(experience)
      ],
    );
  }

  Widget _buildExperienceEntry(Experience experience) {
    return experience.companyController.text.isEmpty &&
            experience.positionController.text.isEmpty &&
            experience.descriptionController.text.isEmpty
        ? Container()
        : Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: themeColor, width: 2),
              ),
            ),
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      experience.positionController.text,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                    Text(
                      formatDateRange(
                        experience.startDateController.text,
                        experience.endDateController.text,
                      ),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: PdfColor(0.5, 0.5, 0.5),
                      ),
                    ),
                  ],
                ),
                if (experience.companyController.text.isNotEmpty ||
                    experience.locationController.text.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        experience.companyController.text,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        experience.locationController.text,
                        style: TextStyle(
                          fontSize: 10,
                          color: PdfColor(0.5, 0.5, 0.5),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    experience.descriptionController.text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 10,
                      color: PdfColor(0.2, 0.2, 0.2),
                      lineSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 2),
              ],
            ),
          );
  }
} 