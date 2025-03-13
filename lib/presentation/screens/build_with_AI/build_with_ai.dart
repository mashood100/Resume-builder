import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_resume_builder/data/repository/ai_text_service.dart';
import 'package:flutter_resume_builder/presentation/screens/build_with_AI/widgets/option_widget.dart';
import 'package:flutter_resume_builder/presentation/screens/build_with_AI/answer_questions/resume_builder_screen.dart';
import 'package:flutter_resume_builder/presentation/providers/resume_builder_provider.dart';

class BuildOptionsDialog extends StatelessWidget {
  const BuildOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Build Your Resume',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            OptionTile(
              icon: Icons.link,
              title: 'Build with LinkedIn Import',
              description: 'Import your LinkedIn profile data',
              onTap: () {
                Navigator.of(context).pop();
                // LinkedIn import functionality will be implemented later
              },
            ),
            const SizedBox(height: 16),
            OptionTile(
              icon: Icons.upload_file,
              title: 'Import Existing Resume',
              description: 'Upload and enhance your current resume',
              onTap: () {
                Navigator.of(context).pop();
                // Import functionality will be implemented later
              },
            ),
            const SizedBox(height: 16),
            OptionTile(
              icon: Icons.question_answer,
              title: 'Build by Answering Questions',
              description:
                  'Create a resume through guided questions and AI will do the magic for you',
              onTap: () {
                Navigator.of(context).pop();
                // Create AITextService instance and pass it to the ResumeBuilderScreen
                final aiService =
                    AITextService(baseUrl: 'https://api.openai.com');
                // Navigate to the ResumeBuilderScreen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) =>
                          ResumeBuilderProvider(aiService: aiService),
                      child: const ResumeBuilderScreen(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
