import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  
  const StepProgressIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (currentStep + 1) / totalSteps,
              minHeight: 10,
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _getStepTitle(currentStep),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Step ${currentStep + 1} of $totalSteps'),
          ],
        ),
      ],
    );
  }
  
  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Basic Information';
      case 1:
        return 'About Yourself';
      case 2:
        return 'Skills';
      case 3:
        return 'Work Experience';
      case 4:
        return 'Education & Projects';
      default:
        return 'Unknown Step';
    }
  }
} 