import 'package:flutter/material.dart';
import '../../../../presentation/screens/input_form/input_form.dart';
import '../../../../presentation/screens/pdf_viewer.dart';
import '../../../../services/pdf_generator.dart';

/// Widget that displays the portrait layout of the split screen
class PortraitLayout extends StatelessWidget {
  final TabController tabController;
  final ScrollController formScrollController;
  final PDFGenerator pdfGenerator;

  const PortraitLayout({
    super.key,
    required this.tabController,
    required this.formScrollController,
    required this.pdfGenerator,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: <Widget>[
        ResumeInputForm(
          scrollController: formScrollController,
          portrait: true,
        ),
        PDFViewer(
          pdfGenerator: pdfGenerator,
        ),
      ],
    );
  }
}
