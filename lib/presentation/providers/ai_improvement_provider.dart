import 'package:flutter/material.dart';
import '../../data/repository/ai_text_service.dart';

class AIImprovementProvider extends ChangeNotifier {
  AIImprovementProvider({required AITextService aiTextService})
      : _aiTextService = aiTextService;

  final AITextService _aiTextService;

  bool _isImproving = false;

  bool get isImproving => _isImproving;

  // ignore: always_specify_types
  Future improveText(String text, {String context = 'resume'}) async {
    if (text.trim().isEmpty) return text;

    _isImproving = true;
    notifyListeners();

    try {
      final String improvedText =
          await _aiTextService.improveText(text, context: context);
      return improvedText;
    } finally {
      _isImproving = false;
      notifyListeners();
    }
  }
}
