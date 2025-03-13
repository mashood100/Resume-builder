import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/resume_builder_provider.dart';
import 'widgets/progress_indicator.dart';
import 'widgets/basic_info_step.dart';
import 'widgets/summary_step.dart';
import 'widgets/skills_step.dart';
import 'widgets/experience_step.dart';
import 'widgets/education_step.dart';

class ResumeBuilderScreen extends StatelessWidget {
  const ResumeBuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ResumeBuilderContent();
  }
}

class _ResumeBuilderContent extends StatelessWidget {
  const _ResumeBuilderContent();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeBuilderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your Resume'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (provider.currentStep > 0) {
              provider.previousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: StepProgressIndicator(
              currentStep: provider.currentStep,
              totalSteps: provider.totalSteps,
            ),
          ),

          // Current step content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildCurrentStep(context, provider.currentStep),
              ),
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (provider.currentStep > 0)
                  ElevatedButton(
                    onPressed: () => provider.previousStep(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: const Text('Previous'),
                  )
                else
                  const SizedBox(width: 80),
                ElevatedButton(
                  onPressed: () => provider.nextStep(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(provider.currentStep < provider.totalSteps - 1
                      ? 'Next'
                      : 'Generate Resume'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context, int step) {
    switch (step) {
      case 0:
        return const BasicInfoStep();
      case 1:
        return const SummaryStep();
      case 2:
        return const SkillsStep();
      case 3:
        return const ExperienceStep();
      case 4:
        return const EducationStep();
      default:
        return const SizedBox.shrink();
    }
  }
}
