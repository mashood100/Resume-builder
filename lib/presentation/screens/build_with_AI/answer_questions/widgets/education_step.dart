import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/share-widgets/frosted_container.dart';
import '../../../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../../../providers/resume_builder_provider.dart';

class EducationStep extends StatefulWidget {
  const EducationStep({Key? key}) : super(key: key);

  @override
  State<EducationStep> createState() => _EducationStepState();
}

class _EducationStepState extends State<EducationStep> {
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _projectDescController = TextEditingController();
  
  @override
  void dispose() {
    _degreeController.dispose();
    _projectController.dispose();
    _projectDescController.dispose();
    super.dispose();
  }
  
  void _addEducation(ResumeBuilderProvider provider) {
    final degree = _degreeController.text.trim();
    final project = _projectController.text.trim();
    final projectDesc = _projectDescController.text.trim();
    
    if (degree.isNotEmpty) {
      provider.addEducation(
        degree,
        project: project,
        projectDescription: projectDesc,
      );
      _degreeController.clear();
      _projectController.clear();
      _projectDescController.clear();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeBuilderProvider>(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Education & Projects",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Add your educational background and notable projects",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        
        // Add new education form
        FrostedContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GenericTextField(
                  label: 'Degree/Major',
                  controller: _degreeController,
                  onSubmitted: (_) {},
                  hintText: 'e.g., Bachelor of Science in Computer Science',
                ),
                const SizedBox(height: 16),
                
                GenericTextField(
                  label: 'Project Name (Optional)',
                  controller: _projectController,
                  onSubmitted: (_) {},
                ),
                const SizedBox(height: 16),
                
                GenericTextField(
                  label: 'Project Description (Optional)',
                  controller: _projectDescController,
                  onSubmitted: (_) {},
                  multiLine: true,
                  maxLines: 3,
                ),
                
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _addEducation(provider),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Education'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // List of added education entries
        if (provider.educations.isNotEmpty) ...[
          const Text(
            "Your Education & Projects",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.educations.length,
            itemBuilder: (context, index) {
              final education = provider.educations[index];
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
                            child: Text(
                              education.degree,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => provider.removeEducation(index),
                          ),
                        ],
                      ),
                      if (education.project.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Project: ${education.project}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (education.projectDescription.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(education.projectDescription),
                        ],
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        
        const SizedBox(height: 24),
        
        // Generate Resume button
        if (provider.currentStep == provider.totalSteps - 1)
          FrostedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Ready to generate your resume?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Generate and show JSON data
                      final jsonData = provider.generateResumeJson();
                      _showResumeJsonDialog(context, jsonData);
                    },
                    icon: const Icon(Icons.description),
                    label: const Text('Generate My Resume'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
  
  void _showResumeJsonDialog(BuildContext context, String jsonData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Resume Data'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SelectableText(jsonData),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
} 