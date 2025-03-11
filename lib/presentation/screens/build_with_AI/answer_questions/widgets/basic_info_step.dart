import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/share-widgets/frosted_container.dart';
import '../../../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../../../providers/resume_builder_provider.dart';

class BasicInfoStep extends StatelessWidget {
  const BasicInfoStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeBuilderProvider>(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Let's start with the basics",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "This information will be displayed at the top of your resume",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        
        FrostedContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GenericTextField(
                  label: 'Full Name',
                  initialValue: provider.name,
                  onChanged: (value) => provider.name = value,
                  onSubmitted: (_) {},
                ),
                const SizedBox(height: 16),
                
                GenericTextField(
                  label: 'Location',
                  initialValue: provider.location,
                  onChanged: (value) => provider.location = value,
                  onSubmitted: (_) {},
                  hintText: 'City, State/Province, Country',
                ),
                const SizedBox(height: 16),
                
                GenericTextField(
                  label: 'Email Address',
                  initialValue: provider.email,
                  onChanged: (value) => provider.email = value,
                  onSubmitted: (_) {},
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                
                GenericTextField(
                  label: 'Phone Number',
                  initialValue: provider.phone,
                  onChanged: (value) => provider.phone = value,
                  onSubmitted: (_) {},
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 