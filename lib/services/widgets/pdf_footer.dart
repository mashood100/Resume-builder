import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../data/models/resume.dart';
import 'pdf_base_widget.dart';

/// Widget for the footer
class PDFFooter extends PDFBaseWidget {
  PDFFooter({
    required this.resume,
    required this.currentPage,
    required this.totalPages,
  });

  final Resume resume;
  final int currentPage;
  final int totalPages;

  Widget build() {
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
} 