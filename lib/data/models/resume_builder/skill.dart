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
