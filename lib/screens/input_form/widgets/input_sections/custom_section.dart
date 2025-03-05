import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../models/generic.dart';
import '../../../../models/resume.dart';
import 'custom_entry.dart';
import '../section_title.dart';

/// A widget that displays a custom section based on a given title.
class CustomSectionWidget extends StatelessWidget {
  /// Creates a new custom section widget.
  const CustomSectionWidget({
    required this.title,
    required this.resume,
    required this.portrait,
    super.key,
  });

  /// The title of the custom section.
  final String title;

  /// The resume model containing the data.
  final Resume resume;

  /// Whether the layout is portrait or not.
  final bool portrait;

  @override
  Widget build(BuildContext context) {
    // Extract the list of custom entries for the given section title.
    final List<GenericEntry> genericSection = <GenericEntry>[];
    for (final Map<String, GenericEntry> section in resume.customSections) {
      if (section.containsKey(title)) {
        genericSection.add(section[title]!);
      }
    }

    return Column(
      children: <Widget>[
        // Section title with editable title, add button, and visibility toggle.
        SectionTitle(
          title: title,
          resume: resume,
          titleEditable: true,
          allowVisibilityToggle: true,
          onAddPressed: () => resume.addCustomSectionEntry(title),
        ),
        // Custom section entries displayed with reduced opacity if hidden.
        Opacity(
          opacity: resume.sectionVisible(title) ? 1 : 0.5,
          child: ReorderableList(
            itemCount: genericSection.length,
            shrinkWrap: true,
            proxyDecorator: _proxyDecorator,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (int oldIndex, int newIndex) {
              resume.onReorderCustomSectionList(oldIndex, newIndex);
            },
            itemBuilder: (BuildContext context, int index) {
              return ReorderableDelayedDragStartListener(
                key: Key('$title$index'),
                index: index,
                child: CustomEntry(
                  portrait: portrait,
                  genericSection: genericSection[index],
                  onRemove: () => resume.onDeleteCustomSectionEntry(
                      genericSection[index], title),
                  enableEditing: resume.sectionVisible(title),
                  rebuild: resume.rebuild,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// A decorator widget that adds a shadow and slight rotation to a widget being reordered.
  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Transform.rotate(
          angle: lerpDouble(0, -0.025, animValue)!,
          child: Material(
            elevation: elevation,
            color: Colors.transparent,
            shadowColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
} 