import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'improve_ai_button.dart';
import '../../../data/enums/resume_field_type.dart';

/// A generic form text field.
class GenericTextField extends StatefulWidget {
  const GenericTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onSubmitted,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.multiLine = false,
    this.roundedStyling = true,
    this.showImproveWithAI = false,
    this.fieldContext = '',
    this.fieldType = ResumeFieldType.general,
  });

  /// The label for the text field.
  final String label;

  /// The controller for the text field.
  final TextEditingController controller;

  /// Whether to use the rounded styling.
  final bool roundedStyling;

  /// Whether the text field is multi-line.
  final bool multiLine;

  /// Whether to show the "Improve with AI" button
  final bool showImproveWithAI;

  /// The context for the field (legacy support)
  final String fieldContext;
  
  /// The specific resume field type (for better AI context)
  final ResumeFieldType fieldType;

  /// The callback when the user submits the text field.
  final Function(String?)? onSubmitted;

  /// Whether the text field is enabled.
  final bool enabled;
  
  /// The keyboard type for the text field.
  final TextInputType? keyboardType;
  
  /// The validator for the text field.
  final String? Function(String?)? validator;

  @override
  State<GenericTextField> createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: UniqueKey().toString(),
          minLines: widget.multiLine ? 2 : 1,
          maxLines: widget.multiLine || widget.multiLine ? 15 : 1,
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: !widget.roundedStyling
              ? const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              : const TextStyle(fontSize: 14),
          decoration: widget.roundedStyling
              ? InputDecoration(
                  label: Text(widget.label),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              : InputDecoration(
                  label: Text(widget.label),
                  border: const UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                ),
          onSubmitted: widget.onSubmitted,
          onSaved: widget.onSubmitted,
        ),
        if (widget.showImproveWithAI && widget.enabled)
          ImproveWithAIButton(
            controller: widget.controller,
            fieldType: widget.fieldType,
            fieldContext: widget.fieldContext.isEmpty ? widget.label.toLowerCase() : widget.fieldContext,
            onImproved: () => widget.onSubmitted?.call(widget.controller.text),
          ),
      ],
    );
  }
}
