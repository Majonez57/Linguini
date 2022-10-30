class Recipe {
  final String title;
  final String description;
  final String? imageSrc;
  final Map<String, String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.title,
    required this.description,
    this.imageSrc,
    required this.ingredients,
    required this.steps,
  });

  // factory Recipe.fromJson(Map<String, dynamic> json) {
  //   return Recipe(title: json['title']);
  // }
}
