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
