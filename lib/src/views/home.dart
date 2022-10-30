import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();

  Future<List<String>?> _getItems() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return null;

    final uri = Uri.http("10.0.247.53:5000", "/tags");

    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        await pickedFile.readAsBytes(),
        filename: 'test.jpg',
      ),
    );

    http.StreamedResponse r = await request.send();

    if (r.statusCode != 200) return null;

    return List.from(jsonDecode(await r.stream.bytesToString()));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   // title: const Text("Linguini"),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(children: [
              Image.file()
              IconButton(
                iconSize: 100.0,
                onPressed: () {
                  _getItems().then((value) {
                    if (value == null) return;
                    print(value);
                    Navigator.pushNamed(context, '/recipes/list',
                        arguments: value);
                  });
                },
                icon: const Icon(Icons.add_a_photo),
              ),
            ],
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
