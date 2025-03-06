import 'package:flutter/material.dart';
import '../../data/repository/ai_text_service.dart';
import '../../data/enums/resume_field_type.dart';

/// Provider to manage AI text improvement state
class AIImprovementProvider extends ChangeNotifier {
  final AITextService _aiTextService;

  bool _isImproving = false;

  /// Get the current improving state
  bool get isImproving => _isImproving;

  /// Constructor
  AIImprovementProvider({required AITextService aiTextService})
      : _aiTextService = aiTextService;

  /// Improve the given text using AI with field type
  Future<String> improveText(String text,
      {ResumeFieldType fieldType = ResumeFieldType.general}) async {
    if (text.trim().isEmpty) return text;

    _isImproving = true;
    notifyListeners();

    try {
      final improvedText =
          await _aiTextService.improveText(text, fieldType: fieldType);
      return improvedText;
    } finally {
      _isImproving = false;
      notifyListeners();
    }
  }

  /// Legacy method for backward compatibility
  Future<String> improveTextWithContext(String text,
      {String context = 'resume'}) async {
    if (text.trim().isEmpty) return text;

    _isImproving = true;
    notifyListeners();

    try {
      final improvedText =
          await _aiTextService.improveTextWithContext(text, context: context);
      return improvedText;
    } finally {
      _isImproving = false;
      notifyListeners();
    }
  }
}
