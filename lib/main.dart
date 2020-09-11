import 'package:flutter/material.dart';
import 'package:html_books_example/http_books/view/http_books.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HttpBooks(),
    );
  }
}
