import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/share-widgets/frosted_container.dart';
import '../../../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../../../providers/resume_builder_provider.dart';

class ExperienceStep extends StatefulWidget {
  const ExperienceStep({Key? key}) : super(key: key);

  @override
  State<ExperienceStep> createState() => _ExperienceStepState();
}

class _ExperienceStepState extends State<ExperienceStep> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  @override
  void dispose() {
    _companyController.dispose();
    _jobTitleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  void _addExperience(ResumeBuilderProvider provider) {
    final company = _companyController.text.trim();
    final jobTitle = _jobTitleController.text.trim();
    final description = _descriptionController.text.trim();
    
    if (company.isNotEmpty && jobTitle.isNotEmpty) {
      provider.addExperience(company, jobTitle, description);
      _companyController.clear();
      _jobTitleController.clear();
      _descriptionController.clear();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeBuilderProvider>(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tell us about your work experience",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Add your relevant work experience, starting with the most recent",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        
        // Add new experience form
        FrostedContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GenericTextField(
                  label: 'Company Name',
                  controller: _companyController,
                  onSubmitted: (_) {},
                ),
                const SizedBox(height: 16),
                
                GenericTextField(
                  label: 'Job Title',
                  controller: _jobTitleController,
                  onSubmitted: (_) {},
                ),
                const SizedBox(height: 16),
                
                GenericTextField(
                  label: 'What did you do there?',
                  controller: _descriptionController,
                  onSubmitted: (_) {},
                  multiLine: true,
                  maxLines: 4,
                  hintText: 'Describe your responsibilities and achievements...',
                ),
                
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _addExperience(provider),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Work Experience'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // List of added experiences
        if (provider.experiences.isNotEmpty) ...[
          const Text(
            "Your Work Experience",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.experiences.length,
            itemBuilder: (context, index) {
              final experience = provider.experiences[index];
              return FrostedContainer(
                // margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  experience.jobTitle,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  experience.company,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => provider.removeExperience(index),
                          ),
                        ],
                      ),
                      if (experience.description.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        Text(experience.description),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ],
    );
  }
} 