import 'dart:typed_data';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../common/strings.dart';
import '../models/education.dart';
import '../models/experience.dart';
import '../models/generic.dart';
import '../models/resume.dart';

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
    return PdfColor(0.2, 0.4, 0.6);
  }

  /// A label for a section.
  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
          Expanded(
            child: Divider(
              indent: 8,
              thickness: 1,
              color: themeColor,
            ),
          ),
        ],
      ),
    );
  }

  /// The resume header.
  ///
  /// Includes the name, location, image, and contact details.
  Widget _header() {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _name(),
            SizedBox(height: 4),
            _location(),
            SizedBox(height: 12),
            Divider(thickness: 0.5, color: themeColor),
            SizedBox(height: 8),
            _contactGrid(),
            SizedBox(height: 10),
          ],
        ),
        if (resume.logoAsBytes != null)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PdfColor(0.95, 0.95, 0.95),
                border: Border.all(color: themeColor, width: 2),
              ),
              child: ClipOval(
                child: Image(
                  MemoryImage(resume.logoAsBytes!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// The contact details of the user.
  Widget _contactGrid() {
    return Table(
      columnWidths: {
        0: const FixedColumnWidth(16),
        1: const FlexColumnWidth(3),
        2: const FixedColumnWidth(16),
        3: const FlexColumnWidth(3),
      },
      children: <TableRow>[
        for (int iterator = 0;
            iterator < resume.contactList.length;
            iterator = iterator + 2)
          TableRow(
            children: <Widget>[
              if (resume.contactList[iterator].textController.text.isNotEmpty)
                Icon(
                  IconData(resume.contactList[iterator].iconData.codePoint),
                  size: 14,
                  color: themeColor,
                )
              else
                Container(width: 1),
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 6),
                child: Text(
                  resume.contactList[iterator].textController.text,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              if (iterator < resume.contactList.length - 1 &&
                  resume
                      .contactList[iterator + 1].textController.text.isNotEmpty)
                Icon(
                  IconData(resume.contactList[iterator + 1].iconData.codePoint),
                  size: 14,
                  color: themeColor,
                )
              else
                Container(),
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 6),
                child: Text(
                  iterator < resume.contactList.length - 1
                      ? resume.contactList[iterator + 1].textController.text
                      : '',
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          )
      ],
    );
  }

  /// The name of the user.
  Widget _name() {
    return Text(
      resume.nameController.text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: themeColor,
      ),
    );
  }

  /// The location of the user.
  Widget _location() {
    return Row(
      children: <Widget>[
        Icon(
          IconData(cupertino.CupertinoIcons.map_pin_ellipse.codePoint),
          size: 14,
          color: themeColor,
        ),
        SizedBox(width: 4),
        Text(
          resume.locationController.text,
          style: const TextStyle(fontSize: 12, color: PdfColor(0.3, 0.3, 0.3)),
        ),
      ],
    );
  }

  /// A date range in the format of `startDate - endDate`.
  String _dateRange(String startDate, String endDate) {
    if (startDate.isEmpty && endDate.isEmpty) {
      return '';
    } else if (startDate.isEmpty) {
      return endDate;
    } else if (endDate.isEmpty) {
      return startDate;
    } else {
      return '$startDate - $endDate';
    }
  }

  /// A custom section.
  Widget _customSection(int index, {required String sectionName}) {
    return resume.customSections.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _sectionLabel(sectionName),
              for (final Map<String, GenericEntry> genericSection
                  in resume.visibleCustomSections)
                if (genericSection.keys.first == sectionName)
                  _genericEntryDetails(genericSection.values.first)
            ],
          );
  }

  /// A generic entry.
  Widget _genericEntryDetails(GenericEntry genericSection) {
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
                      _dateRange(
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

  /// The professional experience section.
  Widget _experienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionLabel(Strings.experience),
        for (final Experience experience in resume.visibleExperiences)
          _experienceEntryDetails(experience)
      ],
    );
  }

  /// An experience entry.
  Widget _experienceEntryDetails(Experience experience) {
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
                      _dateRange(
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

  /// The education section.
  Widget _educationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _sectionLabel(Strings.education),
        for (final Education education in resume.visibleEducation)
          _educationEntryDetails(education)
      ],
    );
  }

  /// An education entry.
  Widget _educationEntryDetails(Education education) {
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
                _dateRange(
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
                style: TextStyle(
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

  /// The skills section.
  Widget _skillsList() {
    return resume.skillTextControllers.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                _sectionLabel(Strings.skills),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: PdfColor(0.95, 0.95, 0.95),
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
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                    ],
                  ),
                ),
                SizedBox(height: 8),
              ]);
  }

  /// The resume footer.
  Widget _footer({required int currentPage, required int totalPages}) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            '${resume.nameController.text} - Page $currentPage / $totalPages',
            style: const TextStyle(color: PdfColor(0.6, 0.6, 0.6), fontSize: 8),
          ),
        ),
      ],
    );
  }

  /// The sections of the resume in the order they should be displayed.
  List<Widget> _getOrderedSections() {
    final List<Widget> sections = <Widget>[];
    int sectionIndex = 0;
    for (final String sectionName in resume.sectionOrder) {
      if (!resume.sectionVisible(sectionName)) {
        continue;
      }
      switch (sectionName) {
        case Strings.skills:
          sections.add(_skillsList());
        case Strings.experience:
          sections.add(_experienceSection());
        case Strings.education:
          sections.add(_educationSection());
        default:
          sections.add(_customSection(sectionIndex, sectionName: sectionName));
      }
      sectionIndex++;
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
            return _header();
          }
          return Container();
        },
        build: (Context context) => _getOrderedSections(),
        footer: (Context context) => Align(
          alignment: Alignment.bottomCenter,
          child: _footer(
            currentPage: context.pageNumber,
            totalPages: context.pagesCount,
          ),
        ),
      ),
    );
    return pdf.save();
  }
}
