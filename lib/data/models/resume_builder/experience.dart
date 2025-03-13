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
