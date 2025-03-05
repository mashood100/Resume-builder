import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../common/strings.dart';
import '../../../models/resume.dart';
import 'section_title.dart';

/// A widget that displays the theme color selection section.
class ThemeColorSection extends StatelessWidget {
  /// Creates a new theme color section widget.
  const ThemeColorSection({
    required this.resume,
    super.key,
  });

  /// The resume model containing the data.
  final Resume resume;

  @override
  Widget build(BuildContext context) {
    // Define 5 preset theme colors
    final List<Color> presetColors = [
      const Color(0xFF2C698D), // Blue
      const Color(0xFF2E8B57), // Sea Green
      const Color(0xFF8B0000), // Dark Red
      const Color(0xFF4B0082), // Indigo
      const Color(0xFF556B2F), // Olive Green
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionTitle(
          title: Strings.theme,
          resume: resume,
          allowVisibilityToggle: false,
          reOrderable: false,
          onAddPressed: null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select a theme color for your resume:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  // Preset color options
                  for (final Color color in presetColors)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          resume.setThemeColor(color);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: resume.themeColor == color
                                  ? Colors.white
                                  : Colors.grey.shade300,
                              width: resume.themeColor == color ? 3 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  // Custom color picker button
                  InkWell(
                    onTap: () async {
                      final Color? pickedColor = await showDialog<Color>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor:
                                    resume.themeColor ?? presetColors[0],
                                onColorChanged: (Color color) {
                                  resume.setThemeColor(color);
                                },
                                enableAlpha: false,
                                labelTypes: const [],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      if (pickedColor != null) {
                        resume.setThemeColor(pickedColor);
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.red, Colors.green, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.colorize,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
} 