import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'improve_ai_button.dart';
import '../../../data/enums/resume_field_type.dart';

/// A generic form text field.
class GenericTextField extends StatefulWidget {
  const GenericTextField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.onSubmitted,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.multiLine = false,
    this.roundedStyling = true,
    this.showImproveWithAI = false,
    this.fieldContext = '',
    this.fieldType = ResumeFieldType.general,
    this.maxLines,
    this.hintText,
  }) : assert(
          (controller != null) ||
              (initialValue != null) ||
              (controller == null && initialValue == null),
          'Either controller or initialValue can be provided, or both can be null',
        );

  /// The label for the text field.
  final String label;

  /// The controller for the text field.
  final TextEditingController? controller;

  /// Initial value for the text field (used when controller is null)
  final String? initialValue;

  /// Whether to use the rounded styling.
  final bool roundedStyling;

  /// Whether the text field is multi-line.
  final bool multiLine;

  /// Maximum number of lines for multi-line text fields
  final int? maxLines;

  /// Hint text to show when the field is empty
  final String? hintText;

  /// Whether to show the "Improve with AI" button
  final bool showImproveWithAI;

  /// The context for the field (legacy support)
  final String fieldContext;

  /// The specific resume field type (for better AI context)
  final ResumeFieldType fieldType;

  /// The callback when the user submits the text field.
  final Function(String?)? onSubmitted;

  /// The callback when the text field value changes
  final Function(String)? onChanged;

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
  late TextEditingController _controller;
  bool _isInternalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _isInternalController = true;
      _controller = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  void didUpdateWidget(GenericTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        // We were using an internal controller, dispose it
        if (_isInternalController) {
          _controller.dispose();
        }
      }

      if (widget.controller != null) {
        _isInternalController = false;
        _controller = widget.controller!;
      } else {
        _isInternalController = true;
        _controller = TextEditingController(text: widget.initialValue);
      }
    } else if (widget.initialValue != oldWidget.initialValue &&
        widget.controller == null &&
        _isInternalController) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: UniqueKey().toString(),
          minLines: widget.multiLine ? 2 : 1,
          maxLines: widget.maxLines ?? (widget.multiLine ? 15 : 1),
          controller: _controller,
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
                  hintText: widget.hintText,
                )
              : InputDecoration(
                  label: Text(widget.label),
                  border: const UnderlineInputBorder(),
                  contentPadding: EdgeInsets.zero,
                  hintText: widget.hintText,
                ),
          onSubmitted: widget.onSubmitted,
          onSaved: widget.onSubmitted,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value ?? "");
            }
          },
        ),
        if (widget.showImproveWithAI && widget.enabled)
          ImproveWithAIButton(
            controller: _controller,
            fieldType: widget.fieldType,
            fieldContext: widget.fieldContext.isEmpty
                ? widget.label.toLowerCase()
                : widget.fieldContext,
            onImproved: () => widget.onSubmitted?.call(_controller.text),
          ),
      ],
    );
  }
}
