import 'package:flutter/material.dart';
import 'package:linguini/src/widgets/shared/SingleExpandableCard.dart';

class RecipeSteps extends StatelessWidget {
  final List<String> steps;

  const RecipeSteps({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    var stepList = steps.asMap().entries.map(((step) => Column(
      children: [
        Divider(),
        ListTile(
          leading: Text((step.key + 1).toString()),
          title: Text(step.value)
        ),
      ],
    )));

    return SingleExpandablePanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return const ListTile(
          title: Text("Instructions"),
        );
      },
      body: Column(
        children: stepList.toList(),
      ),
    );
  }
}