import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../common/strings.dart';
import '../../../../../data/models/resume.dart';
import 'experience_entry.dart';
import '../section_title.dart';

/// A widget that displays the experience section as a reorderable list.
class ExperienceSection extends StatelessWidget {
  /// Creates a new experience section widget.
  const ExperienceSection({
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
          title: Strings.experience,
          resume: resume,
          onAddPressed: resume.addExperience,
        ),
        // Reorderable list for experience entries.
        ReorderableList(
          itemCount: resume.experiences.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          proxyDecorator: _proxyDecorator,
          onReorder: (int oldIndex, int newIndex) {
            resume.onReorderExperienceList(oldIndex, newIndex);
          },
          itemBuilder: (BuildContext context, int index) {
            return ReorderableDelayedDragStartListener(
              key: Key('${Strings.experience}$index'),
              index: index,
              child: ExperienceEntry(
                portrait: portrait,
                experience: resume.experiences[index],
                rebuild: resume.rebuild,
                onRemove: () =>
                    resume.onDeleteExperience(resume.experiences[index]),
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