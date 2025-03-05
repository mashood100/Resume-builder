import 'package:flutter/cupertino.dart' as cupertino;
import 'package:pdf/pdf.dart';

/// Base class for all PDF widgets with common utilities
abstract class PDFBaseWidget {
  /// Converts Flutter Color to PDF Color
  PdfColor flutterColorToPdfColor(cupertino.Color color) {
    return PdfColor(
      color.red / 255,
      color.green / 255,
      color.blue / 255,
      color.alpha / 255,
    );
  }

  /// Format a date range in the format of `startDate - endDate`.
  String formatDateRange(String startDate, String endDate) {
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
} 