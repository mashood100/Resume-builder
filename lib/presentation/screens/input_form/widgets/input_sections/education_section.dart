import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../common/strings.dart';
import '../../../../../data/models/resume.dart';
import 'education_entry.dart';
import '../section_title.dart';

/// A widget that displays the education section as a reorderable list.
class EducationSection extends StatelessWidget {
  /// Creates a new education section widget.
  const EducationSection({
    required this.resume,
    required this.portrait,
    super.key,
  });

  /// The resume model containing the data.
  final Resume resume;

  /// Whether the layout is portrait or not.
  final bool portrait;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Section title with add button.
        SectionTitle(
          title: Strings.education,
          resume: resume,
          onAddPressed: resume.addEducation,
        ),
        // Reorderable list for education entries.
        ReorderableList(
          itemCount: resume.educationHistory.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          proxyDecorator: _proxyDecorator,
          onReorder: (int oldIndex, int newIndex) {
            resume.onReorderEducationList(oldIndex, newIndex);
          },
          itemBuilder: (BuildContext context, int index) {
            return ReorderableDelayedDragStartListener(
              key: Key('${Strings.education}$index'),
              index: index,
              child: EducationEntry(
                portrait: portrait,
                education: resume.educationHistory[index],
                rebuild: resume.rebuild,
                onRemove: () =>
                    resume.onDeleteEducation(resume.educationHistory[index]),
              ),
            );
          },
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