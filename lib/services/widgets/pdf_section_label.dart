import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'pdf_base_widget.dart';

/// Widget for section labels
class PDFSectionLabel extends PDFBaseWidget {
  PDFSectionLabel({required this.text, required this.themeColor});

  final String text;
  final PdfColor themeColor;

  Widget build() {
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
} 