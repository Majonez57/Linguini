import 'package:flutter/material.dart';
import 'package:linguini/src/models/recipe.dart';
import 'package:linguini/src/widgets/recipe/recipeIngredients.dart';
import 'package:linguini/src/widgets/recipe/recipeTitle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/recipe/recipeSteps.dart';

class RecipePage extends StatefulWidget {
  final int recipeId;

  const RecipePage({super.key, required this.recipeId});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late Future<Recipe> recipe;

  @override
  void initState() {
    super.initState();

    recipe = _getRecipe();
  }

  Future<Recipe> _getRecipe() async {
    var uri = Uri.http("10.0.247.53:5000", "/recipes/${widget.recipeId}");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final recipesJson = jsonDecode(response.body);

      print(recipesJson);

      return Recipe(
          title: recipesJson['title'],
          description: recipesJson['description'],
          ingredients: Map<String, String>.from(recipesJson['ingredients']),
          steps: List<String>.from(recipesJson['steps']),
          imageSrc: recipesJson['imageSrc']);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipe"),
        ),
        body: FutureBuilder<Recipe>(
            future: recipe,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      RecipeTitle(
                          title: snapshot.data!.title,
                          imageSrc: snapshot.data!.imageSrc == null ? "" : snapshot.data!.imageSrc!),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(snapshot.data!.description),
                      )),
                      RecipeIngredients(
                        ingredients: snapshot.data!.ingredients,
                      ),
                      RecipeSteps(
                        steps: snapshot.data!.steps,
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.hasError}');
              }

              return Center(child: const CircularProgressIndicator());
            }));
  }
}
