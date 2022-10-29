import 'package:flutter/material.dart';
import 'package:linguini/src/models/recipeShort.dart';
import 'package:linguini/src/widgets/recipe/recipeTitle.dart';

import '../widgets/recipe/recipeSteps.dart';
import '../widgets/recipe/recipeTitleLink.dart';

class RecipeListPage extends StatefulWidget {
  final List<String> recipeId = [];

  RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipeListPage> {
  late Future<List<RecipeShort>> recipes;

  @override
  void initState() {
    super.initState();

    recipes = Future.value([
      const RecipeShort(
        title: "Title 1",
        shortDescription: "Hello, world!",
        imageSrc:
            "https://insanelygoodrecipes.com/wp-content/uploads/2020/06/Tomato-soup.png",
      ),
      const RecipeShort(
        title: "Title 2",
        shortDescription: "Hello, world!",
        imageSrc:
            "https://insanelygoodrecipes.com/wp-content/uploads/2020/06/Tomato-soup.png",
      ),
      const RecipeShort(
        title: "Title 3",
        shortDescription: "Hello, world!",
        imageSrc:
            "https://insanelygoodrecipes.com/wp-content/uploads/2020/06/Tomato-soup.png",
      ),
      const RecipeShort(
        title: "Title 4",
        shortDescription: "Hello, world!",
        imageSrc:
            "https://insanelygoodrecipes.com/wp-content/uploads/2020/06/Tomato-soup.png",
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipe"),
        ),
        body: FutureBuilder<List<RecipeShort>>(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data![index];

                    return RecipeTitleLink(
                        title: item.title,
                        shortDescription: item.shortDescription,
                        imageSrc: item.imageSrc,
                        onTap: () => Navigator.pushNamed(context, '/recipes/view'),
                      );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.hasError}');
              }

              return const CircularProgressIndicator();
            }));
  }
}
