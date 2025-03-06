/// Defines the different types of fields in a resume for AI text improvement
enum ResumeFieldType {
  /// Job experience description
  jobDescription,
  
  /// Education description
  education,
  
  /// Skills description
  skills,
  
  /// Project description
  project,
  
  /// Personal statement or summary
  summary,
  
  /// Custom section description
  customSection,
  
  /// Contact information
  contact,
  
  /// General text - will provide generic improvements
  general;
  
  /// Returns a descriptive prompt for the AI based on field type
  String get aiPrompt {
    switch (this) {
      case ResumeFieldType.jobDescription:
        return 'Enhance this job description to be more impactful using action verbs, metrics, and clear achievements. Make it concise and professional.';
      case ResumeFieldType.education:
        return 'Improve this education description to highlight academic achievements, relevant coursework, and skills gained.';
      case ResumeFieldType.skills:
        return 'Refine this skills list to be more targeted and industry-specific, using relevant keywords.';
      case ResumeFieldType.project:
        return 'Enhance this project description to highlight outcomes, technologies used, and your specific contributions.';
      case ResumeFieldType.summary:
        return 'Polish this professional summary to be concise, compelling, and highlight your key strengths and career focus.';
      case ResumeFieldType.customSection:
        return 'Improve this custom section to be more professional, clear, and impactful.';
      case ResumeFieldType.contact:
        return 'Format this contact information to be professional and consistent.';
      case ResumeFieldType.general:
        return 'Improve this text to be more professional, clear, and impactful for a resume.';
    }
  }
} 