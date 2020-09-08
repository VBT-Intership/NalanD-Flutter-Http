import 'package:flutter/material.dart';
import 'package:html_albums_example/http_albums/view/http_albums.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HttpAlbums(),
    );
  }
}
