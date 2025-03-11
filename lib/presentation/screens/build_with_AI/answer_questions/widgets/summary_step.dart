import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/share-widgets/frosted_container.dart';
import '../../../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../../../providers/resume_builder_provider.dart';

class SummaryStep extends StatelessWidget {
  const SummaryStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeBuilderProvider>(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tell us about yourself",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Write a brief introduction about who you are professionally",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        
        FrostedContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GenericTextField(
                  label: 'Professional Summary',
                  initialValue: provider.introduction,
                  onChanged: (value) => provider.introduction = value,
                  onSubmitted: (_) {},
                  multiLine: true,
                  maxLines: 6,
                  hintText: 'Just describe yourself casually—we\'ll handle the rest for you!',
                ),
                
                const SizedBox(height: 12),
                Text(
                  'Keep it concise and highlight your strengths!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 