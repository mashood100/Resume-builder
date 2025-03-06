import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../common/strings.dart';
import '../../../../data/models/resume.dart';
import '../../../../core/share-widgets/text_field/generic_text_field.dart';
import 'image_file_picker.dart';

/// The header section of the resume form containing name, location, and logo picker.
class ResumeHeader extends StatelessWidget {
  /// Creates a new header widget with name, location fields and logo picker.
  const ResumeHeader({
    required this.resume,
    super.key,
  });

  /// The resume model containing the data.
  final Resume resume;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              ImageFilePicker(
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
              // Add a remove button when an image is selected
              if (resume.logoAsBytes != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextButton.icon(
                    onPressed: () {
                      resume.logoAsBytes = null;
                      resume.rebuild();
                    },
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text(
                      'Remove Image',
                      style: TextStyle(fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
} 