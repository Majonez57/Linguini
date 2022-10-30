import 'package:flutter/material.dart';

class RecipeTitleLink extends StatelessWidget {
  final String title;
  final String shortDescription;
  final String imageSrc;
  final void Function()? onTap;

  const RecipeTitleLink({super.key, required this.title, required this.shortDescription, required this.imageSrc, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageSrc)
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    textScaleFactor: 2,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    shortDescription,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
