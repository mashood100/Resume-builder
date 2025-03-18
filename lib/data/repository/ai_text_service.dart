import 'dart:convert';
import 'dart:developer';
import 'package:flutter_resume_builder/data/repository/promts.dart';
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

  Future<Map?> generateResume(String userData) async {
    try {
      final userPrompt =
          '''You are an expert AI in resume writing and Applicant Tracking Systems (ATS). Your task is to take the following JSON resume data and enhance it while maintaining the exact same JSON structure.

Guidelines:

Improve descriptions to be more impactful and natural, avoiding clichés and robotic language.
Correct any spelling or grammatical mistakes.
Ensure the resume is ATS-friendly and optimized for readability.
Maintain the original data structure and keys—do not modify or rearrange them.
If any fields are missing, intelligently fill them based on the given information.
Expand and refine work experience details to make them more compelling and results-driven.
Return Data in this json structure and return only json nothing else: {
  "resume": {
    "creationDate": "string",
    "lastModified": "string",
    "name": "string",
    "location": "string",
    "contact": [
      {
        "value": "string",
        "iconData": "integer"
      }
    ],
    "experience": [
      {
        "company": "string",
        "position": "string",
        "startDate": "string",
        "endDate": "string",
        "location": "string",
        "description": "string"
      }
    ],
    "education": [
      {
        "institution": "string",
        "degree": "string",
        "startDate": "string",
        "endDate": "string",
        "location": "string"
      }
    ],
    "skills": [
      "string"
    ],
    "customSections": [
      {
        "SectionName": [
          {
            "title": "string",
            "subtitle": "string",
            "startDate": "string",
            "endDate": "string",
            "location": "string",
            "description": "string"
          }
        ]
      }
    ],
    "sectionOrder": [
      "string"
    ],
    "hiddenSections": [
      "string"
    ],
    "logoAsBytes": null,
    "themeColor": null
  },
  "projectVersionInfo": {
    "appName": "string",
    "siteUrl": "string",
    "version": "string",
    "buildNumber": "string"
  }
}
 Here is the user data: $userData

''';

      // userdatePrompt(userData);
      var temp = {
        'model': 'gpt-3.5-turbo',
        'messages': [
          {"role": "system", "content": generateResumeSystemPrompt},
          {"role": "user", "content": userPrompt},
        ],
        'temperature': 0.7,
        'max_tokens': 500,
      };

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api',
        },
        body: jsonEncode(temp),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];

        // Parse the response as JSON
        try {
          final resumeData = jsonDecode(content.toString());
          log("AI Resume Data $content");
          return resumeData as Map;
        } catch (e) {
          print('Error parsing resume JSON: $e');
          return null;
        }
      } else {
        print('Error generating resume: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception when generating resume: $e');
      return null;
    }
  }
}
