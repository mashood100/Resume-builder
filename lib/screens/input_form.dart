import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../common/strings.dart';
import '../models/generic.dart';
import '../models/resume.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/contact_entry.dart';
import '../widgets/custom_entry.dart';
import '../widgets/education_entry.dart';
import '../widgets/experience_entry.dart';
import '../widgets/frosted_container.dart';
import '../widgets/generic_text_field.dart';
import '../widgets/image_file_picker.dart';

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
  /// Builds the header section containing name, location, and logo picker.
  Widget _header(Resume resume) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Left side: Name and location text fields.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                GenericTextField(
                  label: Strings.name,
                  roundedStyling: false,
                  controller: resume.nameController,
                  onSubmitted: (_) => resume.rebuild(),
                ),
                const SizedBox(height: 10),
                GenericTextField(
                  label: Strings.location,
                  roundedStyling: false,
                  controller: resume.locationController,
                  onSubmitted: (_) => resume.rebuild(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 4),
        // Right side: Logo picker widget.
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ImageFilePicker(
            logoFileBytes: resume.logoAsBytes,
            onPressed: () async {
              // Opens file picker to select an image file for the logo.
              final FilePickerResult? result =
                  await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: <String>['jpg', 'png', 'jpeg'],
              );
              if (result != null) {
                resume.logoAsBytes = result.files.first.bytes;
                resume.rebuild();
              }
            },
          ),
        ),
      ],
    );
  }

  /// Builds a section title row with optional editing, deletion, visibility toggling, and reordering buttons.
  Widget _sectionTitle({
    required String title,
    required Resume resume,
    required Function()? onAddPressed,
    bool allowVisibilityToggle = false,
    bool reOrderable = true,
    bool titleEditable = false,
  }) {
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

  /// Builds the contact information section as a reorderable grid.
  Widget _contactSection(Resume resume) {
    return ReorderableBuilder(
        longPressDelay: const Duration(milliseconds: 250),
        enableScrollingWhileDragging: false,
        // Styling for the widget being dragged.
        dragChildBoxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: Offset(-2, 5),
            ),
          ],
        ),
        builder: (List<Widget> children) {
          return GridView.custom(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childrenDelegate: SliverChildListDelegate(
              children,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 74,
              crossAxisCount: widget.portrait ? 1 : 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          );
        },
        // Generate the list of contact entry widgets.
        children: List<Widget>.generate(
          resume.contactList.length,
          (int index) => ContactEntry(
            key: UniqueKey(),
            contact: resume.contactList[index],
            onTextSubmitted: (String? value) {
              resume.rebuild();
            },
            onIconButtonPressed: () async {
              // Opens an icon picker when the icon button is pressed.
              final IconData? iconData = await FlutterIconPicker.showIconPicker(
                  context,
                  iconPackModes: <IconPack>[IconPack.cupertino]);
              if (iconData != null) {
                resume.contactList[index].iconData = iconData;
              }
              resume.rebuild();
            },
          ),
        ),
        // Handle the reordering callback.
        onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
          for (final OrderUpdateEntity element in orderUpdateEntities) {
            resume.onReorderContactInfoList(element.oldIndex, element.newIndex);
          }
        });
  }

  /// Builds the skills section containing a title and a reorderable grid of skill text fields.
  Widget _skillsSection(Resume resume) {
    return Column(
      children: <Widget>[
        // Section title with add button and visibility toggle.
        _sectionTitle(
          title: Strings.skills,
          resume: resume,
          allowVisibilityToggle: true,
          onAddPressed: resume.addSkill,
        ),
        // The skills list is displayed with reduced opacity if the section is hidden.
        Opacity(
          opacity: resume.sectionVisible(Strings.skills) ? 1 : 0.5,
          child: ReorderableBuilder(
            longPressDelay: const Duration(milliseconds: 250),
            enableScrollingWhileDragging: false,
            // Styling for the widget being dragged.
            dragChildBoxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(-2, 5),
                ),
              ],
            ),
            onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
              // Update the order of skills.
              for (final OrderUpdateEntity element in orderUpdateEntities) {
                resume.onReorderSkillsList(element.oldIndex, element.newIndex);
              }
            },
            builder: (List<Widget> children) {
              return GridView.custom(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childrenDelegate: SliverChildListDelegate(children),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 74,
                  crossAxisCount: widget.portrait ? 2 : 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              );
            },
            // Generate each skill text field inside a frosted container.
            children: List<Widget>.generate(
              resume.skillTextControllers.length,
              (int index) => FrostedContainer(
                key: UniqueKey(),
                child: TextFormField(
                  controller: resume.skillTextControllers[index],
                  enabled: resume.sectionVisible(Strings.skills),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onFieldSubmitted: (String value) {
                    resume.rebuild();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the experience section as a reorderable list of experience entries.
  Widget _experienceSection(Resume resume) {
    return Column(
      children: <Widget>[
        // Section title with add button.
        _sectionTitle(
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
                portrait: widget.portrait,
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

  /// Builds the education section as a reorderable list of education entries.
  Widget _educationSection(Resume resume) {
    return Column(
      children: <Widget>[
        // Section title with add button.
        _sectionTitle(
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
                portrait: widget.portrait,
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

  /// Builds a custom section based on a given title.
  Widget _customSection({required String title, required Resume resume}) {
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
        _sectionTitle(
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
                  portrait: widget.portrait,
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

  /// Orders and returns the list of sections in the order specified by the resume model.
  List<Widget> _orderedSections(Resume resume) {
    final List<Widget> sections = <Widget>[];
    // Loop over the section order list and add the corresponding section widget.
    for (final String sectionTitle in resume.sectionOrder) {
      switch (sectionTitle) {
        case Strings.skills:
          sections.add(_skillsSection(resume));
        case Strings.experience:
          sections.add(_experienceSection(resume));
        case Strings.education:
          sections.add(_educationSection(resume));
        default:
          // Custom section if title does not match the predefined ones.
          sections.add(_customSection(title: sectionTitle, resume: resume));
      }
    }
    return sections;
  }

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
                    _header(resume),
                    const SizedBox(height: 10),
                    // Contact information section.
                    _contactSection(resume),
                    // Spread the ordered sections (skills, experience, education, custom).
                    ..._orderedSections(resume),
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
