import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../../../services/file_handler.dart';
import '../../../../services/pdf_generator.dart';
import '../../../../services/project_info.dart';
import '../../../../services/redirect_handler.dart';
import '../../../../common/strings.dart';
import '../../../../data/models/resume.dart';
import '../../../../core/share-widgets/download_dialog.dart';
import '../../../../core/share-widgets/confirmation_dialog.dart';
import '../widgets/list_option.dart';

/// Manager class to handle the business logic for the split screen
class SplitScreenManager {
  final Resume resume;
  final PDFGenerator pdfGenerator;
  final ProjectVersionInfoHandler projectInfoHandler;
  final ScrollController formScrollController;
  final VoidCallback onStateChanged;

  SplitScreenManager({
    required this.resume,
    required this.pdfGenerator,
    required this.projectInfoHandler,
    required this.formScrollController,
    required this.onStateChanged,
  });

  /// Handle navigation rail destination selection
  void handleDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        _handleClearResume(context);
      case 1:
        _handleImportResume(context);
      case 2:
        _handleDownload(context);
      case 3:
        _handlePrint();
      case 4:
        // Reserved for future use
        break;
      case 5:
        RedirectHandler.openUrl(Strings.sourceCodeUrl);
      case 6:
        RedirectHandler.openUrl(Strings.sponsorUrl);
    }
  }

  /// Handle recompile button press
  void handleRecompile() {
    resume.formKey.currentState!.save();
  }

  /// Handle clearing the resume
  void _handleClearResume(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ConfirmationDialog(
        title: Strings.clearResume,
        content: Strings.clearResumeWarning,
        confirmText: Strings.clear,
        onConfirm: () {
          // Reset resume logic should be implemented by the parent widget
          onStateChanged();
        },
      ),
    );
  }

  /// Handle importing a resume
  void _handleImportResume(BuildContext context) {
    FileHandler().importResume().then((dynamic result) {
      if (result != null) {
        // Import resume logic should be implemented by the parent widget
        onStateChanged();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Strings.noValidJsonFile,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red[700],
          ),
        );
      }
    });
  }

  /// Handle downloading the resume
  void _handleDownload(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => DownloadDialog(
        onDownloadPdf: () async {
          await FileHandler().savePDF(pdfGenerator);
        },
        onDownloadJson: () {
          FileHandler().saveJSONData(
            pdfGenerator: pdfGenerator,
            projectVersionInfoHandler: projectInfoHandler,
          );
        },
      ),
    );
  }

  /// Handle printing the resume
  void _handlePrint() {
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) => pdfGenerator.generateResumeAsPDF(),
    );
  }

  /// Get action items for drawer
  List<Widget> getDrawerActionItems(BuildContext context) {
    return [
      ListOption(
        title: Strings.printPDF,
        iconData: Icons.print,
        onTap: () async {
          Navigator.pop(context);
          _handlePrint();
        },
      ),
    ];
  }
}
