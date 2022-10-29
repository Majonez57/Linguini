import 'package:flutter/material.dart';
import 'package:linguini/src/widgets/shared/SingleExpandableCard.dart';

class RecipeIngredients extends StatelessWidget {
  final Map<String, int> ingredients;

  const RecipeIngredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    var ingredientEntries = ingredients.entries.map((item) => Column(
      children: <Widget>[
        const Divider(),
        ListTile(
          leading: const Icon(Icons.add),
          title: Text(item.key),
          trailing: Text(item.value.toString()),
        ),
      ]
    ));

    return SingleExpandablePanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return const ListTile(
          title: Text("Ingredients"),
        );
      },
      body: Column(
        children: ingredientEntries.toList(),
      ),
    );
  }
}
