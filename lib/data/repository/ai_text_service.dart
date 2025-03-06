import 'dart:convert';
import 'package:http/http.dart' as http;


class AITextService {

  AITextService({
    required this.baseUrl,
  });
  final String baseUrl;

  final api =
      "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";

  /// Improves the provided text based on the given context.
  Future<String> improveText(String text, {String context = 'resume'}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/improve'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $api',
        },
        body: jsonEncode({
          'text': text,
          'context': context,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Ensure the returned value is a String.
        return (data['improved_text'] ?? text).toString();
      } else {
        print('Error improving text: ${response.statusCode}');
        return text;
      }
    } catch (e) {
      print('Exception when improving text: $e');
      return text;
    }
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
