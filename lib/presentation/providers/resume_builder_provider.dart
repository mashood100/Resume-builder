import 'dart:convert';
import 'package:flutter/material.dart';
import '../../data/models/resume_builder/skill.dart';
import '../../data/models/resume_builder/experience.dart';
import '../../data/models/resume_builder/education.dart';
import '../../data/repository/ai_text_service.dart';

class ResumeBuilderProvider extends ChangeNotifier {
  final AITextService _aiService;

  ResumeBuilderProvider({required AITextService aiService})
      : _aiService = aiService;

  int _currentStep = 0;

  // Basic Info
  String name = '';
  String location = '';
  String email = '';
  String phone = '';
  String introduction = '';

  // Skills
  List<Skill> skills = [];

  // Work Experience
  List<Experience> experiences = [];

  // Education & Projects
  List<Education> educations = [];

  // Properties for AI interaction
  bool _isGeneratingResume = false;
  String? _generationError;

  // Getters
  int get currentStep => _currentStep;
  int get totalSteps => 5; // Total number of steps in the form
  double get progress => (_currentStep + 1) / totalSteps;
  bool get isGeneratingResume => _isGeneratingResume;
  String? get generationError => _generationError;

  // Navigation methods
  void nextStep() {
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      _currentStep = step;
      notifyListeners();
    }
  }

  // Data management methods
  void addSkill(String name, int years) {
    skills.add(Skill(name: name, years: years));
    notifyListeners();
  }

  void removeSkill(int index) {
    if (index >= 0 && index < skills.length) {
      skills.removeAt(index);
      notifyListeners();
    }
  }

  void addExperience(String company, String jobTitle, String description) {
    experiences.add(Experience(
      company: company,
      jobTitle: jobTitle,
      description: description,
    ));
    notifyListeners();
  }

  void removeExperience(int index) {
    if (index >= 0 && index < experiences.length) {
      experiences.removeAt(index);
      notifyListeners();
    }
  }

  void addEducation(String degree,
      {String project = '', String projectDescription = ''}) {
    educations.add(Education(
      degree: degree,
      project: project,
      projectDescription: projectDescription,
    ));
    notifyListeners();
  }

  void removeEducation(int index) {
    if (index >= 0 && index < educations.length) {
      educations.removeAt(index);
      notifyListeners();
    }
  }

  // Generate resume JSON
  String generateResumeJson() {
    final Map<String, dynamic> resumeData = {
      'basicInfo': {
        'name': name,
        'location': location,
        'email': email,
        'phone': phone,
        'introduction': introduction,
      },
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'experiences': experiences.map((exp) => exp.toJson()).toList(),
      'education': educations.map((edu) => edu.toJson()).toList(),
    };

    return jsonEncode(resumeData);
  }

  // Reset all data
  void reset() {
    _currentStep = 0;
    name = '';
    location = '';
    email = '';
    phone = '';
    introduction = '';
    skills.clear();
    experiences.clear();
    educations.clear();
    notifyListeners();
  }

  // Generate resume with AI using the AITextService
  Future<Map?> generateResumeWithAI() async {
    if (_isGeneratingResume) return null;

    try {
      _isGeneratingResume = true;
      _generationError = null;
      notifyListeners();

      // Create the data structure to send to the AI service
      final Map<String, dynamic> userData = {
        'basicInfo': {
          'name': name,
          'location': location,
          'email': email,
          'phone': phone,
          'introduction': introduction,
        },
        'skills': skills.map((skill) => skill.toJson()).toList(),
        'experiences': experiences.map((exp) => exp.toJson()).toList(),
        'education': educations.map((edu) => edu.toJson()).toList(),
      };
   
      // Call the AI service to generate a formatted resume
      final resumeData = await _aiService.generateResume(generateResumeJson());

      _isGeneratingResume = false;

      if (resumeData == null) {
        _generationError =
            "Failed to generate resume with AI. Please try again.";
      }

      notifyListeners();
      return resumeData;
    } catch (e) {
      _isGeneratingResume = false;
      _generationError = e.toString();
      notifyListeners();
      return null;
    }
  }

}
