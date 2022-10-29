import 'package:flutter/material.dart';
import 'package:linguini/src/models/recipe.dart';
import 'package:linguini/src/widgets/recipe/recipeIngredients.dart';
import 'package:linguini/src/widgets/recipe/recipeTitle.dart';

import '../widgets/recipe/recipeSteps.dart';

class RecipePage extends StatefulWidget {
  final int recipeId = 0;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late Future<Recipe> recipe;

  @override
  void initState() {
    super.initState();
    
    recipe = Future.value(const Recipe(
      title: "Title",
      shortDescription: "Hello, world!",
      description: "This is a description",
      imageSrc: "https://insanelygoodrecipes.com/wp-content/uploads/2020/06/Tomato-soup.png",
      ingredients: {"onion": 1, "hat": 2},
      steps: ["Make app", "Use app", "????", "Profit"],
    ));
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
          if(snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RecipeTitle(title: snapshot.data!.title, shortDescription: snapshot.data!.shortDescription, imageSrc: snapshot.data!.imageSrc!),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(snapshot.data!.description),
                    )
                  ),
                  RecipeIngredients(
                    ingredients: snapshot.data!.ingredients,
                  ),
                  RecipeSteps(
                    steps: snapshot.data!.steps,
                  )
                ],
              ),
            );
          } else if(snapshot.hasError) {
            return Text('${snapshot.hasError}');
          }

          return const CircularProgressIndicator();
        }
      )
    );
  }
}
