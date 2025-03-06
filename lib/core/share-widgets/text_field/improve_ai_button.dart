import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../presentation/providers/ai_improvement_provider.dart';
import '../../../data/enums/resume_field_type.dart';

/// A button that improves text using AI when pressed
class ImproveWithAIButton extends StatelessWidget {
  /// The text controller to read from and write to
  final TextEditingController controller;

  /// The field type (for AI context-specific improvements)
  final ResumeFieldType fieldType;
  
  /// Fallback field context (legacy support)
  final String fieldContext;

  /// Optional callback to execute after text is improved
  final Function()? onImproved;

  /// Creates an ImproveWithAIButton
  const ImproveWithAIButton({
    Key? key,
    required this.controller,
    this.fieldType = ResumeFieldType.general,
    this.fieldContext = '',
    this.onImproved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AIImprovementProvider>(
      builder: (context, aiProvider, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: SizedBox(
            height: 32,
            child: TextButton.icon(
              onPressed: aiProvider.isImproving
                  ? null
                  : () async {
                      final String currentText = controller.text;
                      if (currentText.trim().isEmpty) return;

                      String improvedText;
                      // Use the new enum-based method if no fieldContext is provided
                      if (fieldContext.isEmpty) {
                        improvedText = await aiProvider.improveText(
                          currentText, 
                          fieldType: fieldType,
                        );
                      } else {
                        // Legacy support for existing implementations
                        improvedText = await aiProvider.improveTextWithContext(
                          currentText,
                          context: fieldContext,
                        );
                      }

                      controller.text = improvedText.toString();
                      onImproved?.call();
                    },
              icon: aiProvider.isImproving
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.auto_fix_high, size: 14),
              label: Text(
                aiProvider.isImproving ? 'Improving...' : 'Improve with AI',
                style: TextStyle(fontSize: 12),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.3),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        );
      },
    );
  }
}
