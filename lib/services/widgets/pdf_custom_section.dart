import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../data/models/generic.dart';
import '../../data/models/resume.dart';
import 'pdf_base_widget.dart';
import 'pdf_section_label.dart';

/// Widget for custom sections
class PDFCustomSection extends PDFBaseWidget {
  PDFCustomSection({required this.resume, required this.themeColor, required this.sectionName});

  final Resume resume;
  final PdfColor themeColor;
  final String sectionName;

  Widget build() {
    return resume.customSections.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PDFSectionLabel(text: sectionName, themeColor: themeColor).build(),
              for (final Map<String, GenericEntry> genericSection
                  in resume.visibleCustomSections)
                if (genericSection.keys.first == sectionName)
                  _buildGenericEntry(genericSection.values.first)
            ],
          );
  }

  Widget _buildGenericEntry(GenericEntry genericSection) {
    return genericSection.titleController.text.isEmpty &&
            genericSection.descriptionController.text.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!(genericSection.titleController.text.isEmpty &&
                  genericSection.startDateController.text.isEmpty &&
                  genericSection.endDateController.text.isEmpty))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      genericSection.titleController.text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatDateRange(
                        genericSection.startDateController.text,
                        genericSection.endDateController.text,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              if (!(genericSection.subtitleController.text.isEmpty &&
                  genericSection.locationController.text.isEmpty))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      genericSection.subtitleController.text,
                    ),
                    Text(
                      genericSection.locationController.text,
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Text(
                  genericSection.descriptionController.text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                    color: PdfColor(0.15, 0.15, 0.15),
                  ),
                ),
              ),
            ],
          );
  }
} 