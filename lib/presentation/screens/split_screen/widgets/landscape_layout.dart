import 'package:flutter/material.dart';
import '../../../../presentation/screens/input_form/input_form.dart';
import '../../../../presentation/screens/pdf_viewer.dart';
import '../../../../services/pdf_generator.dart';
import 'navigation_rail.dart';
import 'recompile_button.dart';

/// Widget that displays the landscape layout of the split screen
class LandscapeLayout extends StatelessWidget {
  final ScrollController formScrollController;
  final PDFGenerator pdfGenerator;
  final Function(int) onDestinationSelected;
  final VoidCallback? onRecompile;

  const LandscapeLayout({
    super.key,
    required this.formScrollController,
    required this.pdfGenerator,
    required this.onDestinationSelected,
    this.onRecompile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CustomNavigationRail(
          onDestinationSelected: onDestinationSelected,
        ),
        Expanded(
          child: ResumeInputForm(
            scrollController: formScrollController,
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              PDFViewer(
                key: GlobalKey(),
                pdfGenerator: pdfGenerator,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: RecompileButton(
                  onPressed: onRecompile,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
