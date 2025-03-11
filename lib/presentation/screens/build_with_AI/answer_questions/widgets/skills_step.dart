import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/share-widgets/frosted_container.dart';
import '../../../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../../../providers/resume_builder_provider.dart';

class SkillsStep extends StatefulWidget {
  const SkillsStep({Key? key}) : super(key: key);

  @override
  State<SkillsStep> createState() => _SkillsStepState();
}

class _SkillsStepState extends State<SkillsStep> {
  final TextEditingController _skillNameController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  
  @override
  void dispose() {
    _skillNameController.dispose();
    _yearsController.dispose();
    super.dispose();
  }
  
  void _addSkill(ResumeBuilderProvider provider) {
    final name = _skillNameController.text.trim();
    final yearsText = _yearsController.text.trim();
    
    if (name.isNotEmpty) {
      final years = int.tryParse(yearsText) ?? 0;
      provider.addSkill(name, years);
      _skillNameController.clear();
      _yearsController.clear();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeBuilderProvider>(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What are your skills?",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Add skills that are relevant to the position you're seeking",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        
        // Add new skill form
        FrostedContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: GenericTextField(
                        label: 'Skill Name',
                        controller: _skillNameController,
                        onSubmitted: (_) => _addSkill(provider),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: GenericTextField(
                        label: 'Years',
                        controller: _yearsController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _addSkill(provider),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _addSkill(provider),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Skill'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // List of added skills
        if (provider.skills.isNotEmpty) ...[
          const Text(
            "Your Skills",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.skills.length,
            itemBuilder: (context, index) {
              final skill = provider.skills[index];
              return FrostedContainer(
                // margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(
                    skill.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${skill.years} ${skill.years == 1 ? 'year' : 'years'} of experience'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => provider.removeSkill(index),
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