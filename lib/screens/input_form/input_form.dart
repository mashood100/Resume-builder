import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../common/strings.dart';
import '../../models/resume.dart';
import 'widgets/input_sections/contact_section.dart';
import 'widgets/ordered_sections.dart';
import 'widgets/resume_header.dart';

/// The input form for the resume.
class ResumeInputForm extends StatefulWidget {
  const ResumeInputForm({
    required this.scrollController,
    super.key,
    this.portrait = false,
  });

  /// Whether the layout is portrait or not.
  final bool portrait;

  /// Controller for scrolling the form.
  final ScrollController scrollController;

  @override
  State<ResumeInputForm> createState() => _ResumeInputFormState();
}

class _ResumeInputFormState extends State<ResumeInputForm> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: widget.scrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<Resume>(
              builder: (BuildContext context, Resume resume, Widget? child) {
            return FormBuilder(
                key: resume.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Header with name, location and logo picker.
                    ResumeHeader(resume: resume),
                    const SizedBox(height: 10),
                    // Contact information section.
                    ContactSection(resume: resume, portrait: widget.portrait),
                    // Spread the ordered sections (skills, experience, education, custom).
                    OrderedSections(resume: resume, portrait: widget.portrait),
                    const SizedBox(height: 10),
                    // Button to add a new custom section.
                    OutlinedButton(
                      onPressed: resume.addCustomSection,
                      child: Text(
                        Strings.addCustomSection.toUpperCase(),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ));
          }),
        ),
      ),
    );
  }
}
