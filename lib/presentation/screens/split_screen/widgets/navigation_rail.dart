import 'package:flutter/material.dart';
import '../../../../common/strings.dart';

/// Custom navigation rail widget for the landscape mode
class CustomNavigationRail extends StatelessWidget {
  final Function(int) onDestinationSelected;

  const CustomNavigationRail({
    super.key,
    required this.onDestinationSelected,
  });

  /// Helper method to get first word of text and uppercase it
  String _firstWordOnly(String text) => text.split(' ').first.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,
      elevation: 12,
      labelType: NavigationRailLabelType.all,
      indicatorColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.surface,
      onDestinationSelected: onDestinationSelected,
      destinations: <NavigationRailDestination>[
        NavigationRailDestination(
          icon: const Tooltip(
              message: Strings.clearResume, child: Icon(Icons.restart_alt)),
          label: Text(
            _firstWordOnly(Strings.clearResume),
          ),
        ),
        NavigationRailDestination(
          icon: const Tooltip(
            message: Strings.importJson,
            child: Icon(Icons.upload_file),
          ),
          label: Text(
            _firstWordOnly(Strings.importJson),
          ),
        ),
        NavigationRailDestination(
          icon: const Tooltip(
            message: Strings.downloadPdfAndJson,
            child: Icon(Icons.download),
          ),
          label: Text(
            _firstWordOnly(Strings.downloadPdfAndJson),
          ),
        ),
        NavigationRailDestination(
          icon: const Tooltip(
            message: Strings.printPDF,
            child: Icon(Icons.print),
          ),
          label: Text(
            _firstWordOnly(Strings.printPDF),
          ),
        ),
      ],
    );
  }
}
