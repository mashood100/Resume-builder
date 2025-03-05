import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:provider/provider.dart';

import '../services/pdf_generator.dart';
import '../core/share-widgets/flutter_spinner.dart';
import '../services/theme_provider.dart';

/// Displays the generated PDF.
class PDFViewer extends StatefulWidget {
  const PDFViewer({super.key, required this.pdfGenerator});

  /// The PDF generator to use.
  final PDFGenerator pdfGenerator;

  @override
  State<StatefulWidget> createState() => PDFViewerState();
}

class PDFViewerState extends State<PDFViewer> {
  /// The PDF generator.
  late PDFGenerator pdfGenerator;

  @override
  void initState() {
    super.initState();
    pdfGenerator = widget.pdfGenerator;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: pdfGenerator.generateResumeAsPDF(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const Center(
              child: FlutterSpinner(),
            ),
          );
        }

        // Use the current theme mode to determine PDF viewer brightness
        final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
        final Brightness brightness =
            themeProvider.isDarkMode ? Brightness.dark : Brightness.light;

        return Theme(
          data: Theme.of(context).copyWith(brightness: brightness),
          child: SfPdfViewer.memory(
            snapshot.data as Uint8List,
            interactionMode: PdfInteractionMode.pan,
            canShowPageLoadingIndicator: false,
            pageLayoutMode: PdfPageLayoutMode.single,
            scrollDirection: PdfScrollDirection.horizontal,
          ),
        );
      },
    );
  }
}
