import 'package:flutter/material.dart';
import 'package:linguini/src/models/recipeShort.dart';
import 'package:linguini/src/widgets/recipe/recipeTitle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/recipe/recipeSteps.dart';
import '../widgets/recipe/recipeTitleLink.dart';

class RecipeListPage extends StatefulWidget {
  final List<String> recipeId;

  const RecipeListPage({super.key, required this.recipeId});

  @override
  State<RecipeListPage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipeListPage> {
  late Future<List<RecipeShort>> recipes;

  static Future<List<RecipeShort>> _fetchRecipes(List<String> tags) async {
    var uri = Uri.http("10.0.247.53:5000", "/recipes", {"tags": tags});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final recipesJson = jsonDecode(response.body);
      List<dynamic> recipes = recipesJson != null ? List.from(recipesJson) : [];
      
      return recipes.map((x) => RecipeShort(
              id: x['id'],
              title: x['title'],
              shortDescription: x['shortDescription'],
              imageSrc: x['imageSrc']))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();

    recipes = _fetchRecipes(["egg"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recipe"),
        ),
        body: Center(
            child: FutureBuilder<List<RecipeShort>>(
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
                          onTap: () =>
                              Navigator.pushNamed(context, '/recipes/view', arguments: item.id),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error fetching recipes!');
                  }

                  return const CircularProgressIndicator();
                })));
  }
}
