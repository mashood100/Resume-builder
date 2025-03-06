import 'dart:convert';
import 'package:http/http.dart' as http;
import '../enums/resume_field_type.dart';

class AITextService {
  AITextService({
    required this.baseUrl,
  });
  final String baseUrl;

  final api =
      "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";

  /// Improves the provided text based on the given field type.
  Future<String> improveText(String text,
      {ResumeFieldType fieldType = ResumeFieldType.general}) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              "role": "system",
              "content":
                  "You are a professional resume writer and career coach. Your task is to improve resume text to be more effective, professional, and impactful."
            },
            {
              "role": "user",
              "content": "${fieldType.aiPrompt}\n\nOriginal text:\n$text"
            },
          ],
          'temperature': 0.7,
          'max_tokens': 500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Extract the improved text from the response
        final improvedText = data['choices'][0]['message']['content'] ?? text;
        return improvedText.toString();
      } else {
        print('Error improving text: ${response.statusCode}');
        return text;
      }
    } catch (e) {
      print('Exception when improving text: $e');
      return text;
    }
  }

  /// Legacy method for backward compatibility
  Future<String> improveTextWithContext(String text,
      {String context = 'resume'}) async {
    // Map the context string to ResumeFieldType
    ResumeFieldType fieldType;
    switch (context.toLowerCase()) {
      case 'job description':
        fieldType = ResumeFieldType.jobDescription;
        break;
      case 'education':
        fieldType = ResumeFieldType.education;
        break;
      case 'skills':
        fieldType = ResumeFieldType.skills;
        break;
      case 'project':
        fieldType = ResumeFieldType.project;
        break;
      case 'summary':
        fieldType = ResumeFieldType.summary;
        break;
      case 'custom section':
      case 'description':
        fieldType = ResumeFieldType.customSection;
        break;
      case 'contact':
        fieldType = ResumeFieldType.contact;
        break;
      default:
        fieldType = ResumeFieldType.general;
    }

    return improveText(text, fieldType: fieldType);
  }

  Future<String> chat(String prompt,
      {String systemPrompt = 'You are a helpful assistant.'}) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {"role": "system", "content": systemPrompt},
            {"role": "user", "content": prompt},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Explicitly convert the dynamic response to a String.
        return (data['choices'][0]['message']['content'] ?? '').toString();
      } else {
        print('Error during chat: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Exception during chat: $e');
      return '';
    }
  }
}
