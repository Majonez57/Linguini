class Recipe {
  final String title;
  final String shortDescription;
  final String description;
  final String? imageSrc;
  final Map<String, int> ingredients;
  final List<String> steps;

  const Recipe({
    required this.title,
    required this.shortDescription,
    required this.description,
    this.imageSrc,
    required this.ingredients,
    required this.steps,
  });

  // factory Recipe.fromJson(Map<String, dynamic> json) {
  //   return Recipe(title: json['title']);
  // }
}
