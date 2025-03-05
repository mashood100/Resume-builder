import 'package:flutter/material.dart';

import '../../../common/strings.dart';
import '../../../models/resume.dart';
import 'input_sections/custom_section.dart';
import 'input_sections/education_section.dart';
import 'input_sections/experience_section.dart';
import 'input_sections/skills_section.dart';
import 'theme_color_section.dart';

/// A widget that orders and returns the list of sections in the order specified by the resume model.
class OrderedSections extends StatelessWidget {
  /// Creates a new ordered sections widget.
  const OrderedSections({
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
    final List<Widget> sections = <Widget>[];

    // Add theme color section at the top
    sections.add(ThemeColorSection(resume: resume));

    // Loop over the section order list and add the corresponding section widget.
    for (final String sectionTitle in resume.sectionOrder) {
      switch (sectionTitle) {
        case Strings.skills:
          sections.add(SkillsSection(resume: resume, portrait: portrait));
        case Strings.experience:
          sections.add(ExperienceSection(resume: resume, portrait: portrait));
        case Strings.education:
          sections.add(EducationSection(resume: resume, portrait: portrait));
        default:
          // Custom section if title does not match the predefined ones.
          sections.add(CustomSectionWidget(
            title: sectionTitle, 
            resume: resume, 
            portrait: portrait
          ));
      }
    }
    return Column(children: sections);
  }
} 