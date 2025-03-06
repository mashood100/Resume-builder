import 'package:flutter/material.dart';

import '../../../../common/strings.dart';
import '../../../../data/models/resume.dart';
import '../../../../core/share-widgets/confirmation_dialog.dart';
import '../../../../core/share-widgets/text_field/generic_text_field.dart';

/// A widget that displays a section title with optional editing, deletion,
/// visibility toggling, and reordering buttons.
class SectionTitle extends StatelessWidget {
  /// Creates a new section title widget.
  const SectionTitle({
    required this.title,
    required this.resume,
    super.key,
    this.onAddPressed,
    this.allowVisibilityToggle = false,
    this.reOrderable = true,
    this.titleEditable = false,
  });

  /// The title of the section.
  final String title;

  /// The resume model containing the data.
  final Resume resume;

  /// Callback for when the add button is pressed.
  final Function()? onAddPressed;

  /// Whether to show the visibility toggle button.
  final bool allowVisibilityToggle;

  /// Whether the section can be reordered.
  final bool reOrderable;

  /// Whether the title can be edited.
  final bool titleEditable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          // If the title is editable, show a text field for renaming.
          if (titleEditable)
            Expanded(
              flex: 2,
              child: GenericTextField(
                key: UniqueKey(),
                label: '',
                controller: TextEditingController(text: title),
                roundedStyling: false,
                onSubmitted: (String? value) {
                  resume.renameCustomSection(title, value.toString());
                },
              ),
            ),
          // Otherwise, display the section title.
          if (!titleEditable)
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          // Divider between title and buttons.
          const Expanded(
            child: Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.white,
            ),
          ),
          // Remove section button if allowed.
          if (resume.removeAllowed(title))
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ConfirmationDialog(
                    title: Strings.removeSection,
                    content: Strings.removeSectionWarning,
                    confirmText: Strings.remove,
                    onConfirm: () {
                      resume.onDeleteCustomSection(title);
                    },
                  ),
                );
              },
              tooltip: Strings.removeSection,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              iconSize: 18,
              icon: const Icon(Icons.delete_outline),
            ),
          // Toggle section visibility if allowed.
          if (allowVisibilityToggle)
            IconButton(
              onPressed: () => resume.toggleSectionVisibility(title),
              tooltip: resume.sectionVisible(title)
                  ? Strings.hideSection
                  : Strings.showSection,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              iconSize: 18,
              icon: Icon(
                resume.sectionVisible(title)
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
          // Add new entry button.
          if (onAddPressed != null)
            IconButton(
              onPressed: onAddPressed,
              tooltip: Strings.newEntry,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              iconSize: 18,
              icon: const Icon(Icons.add),
            ),
          // Move section up button if reordering is enabled.
          if (reOrderable)
            IconButton(
              onPressed: resume.moveUpAllowed(title)
                  ? () => resume.moveUp(title)
                  : null,
              tooltip: Strings.moveSectionUp,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              iconSize: 18,
              icon: const Icon(Icons.expand_less_outlined),
            ),
          // Move section down button if reordering is enabled.
          if (reOrderable)
            IconButton(
              onPressed: resume.moveDownAllowed(title)
                  ? () => resume.moveDown(title)
                  : null,
              tooltip: Strings.moveSectionDown,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              iconSize: 18,
              icon: const Icon(Icons.expand_more_outlined),
            ),
        ],
      ),
    );
  }
} 