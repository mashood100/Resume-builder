import 'dart:convert';
import 'package:flutter/material.dart';

class Skill {
  String name;
  int years;
  
  Skill({required this.name, required this.years});
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'years': years,
    };
  }
}

class Experience {
  String company;
  String jobTitle;
  String description;
  
  Experience({
    required this.company,
    required this.jobTitle,
    required this.description,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'jobTitle': jobTitle,
      'description': description,
    };
  }
}

class Education {
  String degree;
  String project;
  String projectDescription;
  
  Education({
    required this.degree,
    this.project = '',
    this.projectDescription = '',
  });
  
  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'project': project,
      'projectDescription': projectDescription,
    };
  }
}

class ResumeBuilderProvider extends ChangeNotifier {
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
  
  // Getters
  int get currentStep => _currentStep;
  int get totalSteps => 5; // Total number of steps in the form
  double get progress => (_currentStep + 1) / totalSteps;
  
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
  
  void addEducation(String degree, {String project = '', String projectDescription = ''}) {
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
} 