import 'package:flutter/material.dart';
import 'package:linguini/src/views/recipeList.dart';
import 'package:linguini/src/views/recipePage.dart';

import 'src/views/home.dart';

void main() {
  runApp(const LinguiniApp());
}

class LinguiniApp extends StatelessWidget {
  const LinguiniApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          '/': (context) => const Home(),
          '/recipes/list': (context) => RecipeListPage(recipeId: settings.arguments as List<String>),
          '/recipes/view': (context) => RecipePage(recipeId: settings.arguments as int,)
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
