import 'package:flutter/cupertino.dart' as cupertino;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../data/models/resume.dart';
import 'pdf_base_widget.dart';

/// Widget for the resume header section
class PDFHeader extends PDFBaseWidget {
  PDFHeader({required this.resume, required this.themeColor});

  final Resume resume;
  final PdfColor themeColor;

  Widget build() {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildName(),
            SizedBox(height: 4),
            _buildLocation(),
            SizedBox(height: 12),
            Divider(thickness: 0.5, color: themeColor),
            SizedBox(height: 8),
            _buildContactGrid(),
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

  Widget _buildName() {
    return Text(
      resume.nameController.text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: themeColor,
      ),
    );
  }

  Widget _buildLocation() {
    return resume.locationController.text == ''
        ? SizedBox()
        : Row(
            children: <Widget>[
              Icon(
                IconData(cupertino.CupertinoIcons.map_pin_ellipse.codePoint),
                size: 14,
                color: themeColor,
              ),
              SizedBox(width: 4),
              Text(
                resume.locationController.text,
                style: const TextStyle(
                    fontSize: 12, color: PdfColor(0.3, 0.3, 0.3)),
              ),
            ],
          );
  }

  Widget _buildContactGrid() {
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
} 