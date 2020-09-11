import 'package:flutter/material.dart';

import 'package:html_books_example/http_books/model/http_book_model.dart';
import 'package:html_books_example/http_books/service/IHttpBookService.dart';
import 'package:html_books_example/http_books/service/http_book_service.dart';
import '../view/http_books.dart';

abstract class HttpBooksViewModel extends State<HttpBooks> {
  bool isLoading = false;
  List<HttpBookModel> httpBooks = [];

  IHttpBookService httpBookService;

  @override
  void initState() {
    super.initState();
    httpBookService = HttpBookService();
    callItems();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> callItems() async {
    changeLoading();
    await _getHttpBooks();
    changeLoading();
    checkErrorList();
  }

  void checkErrorList() {
    if (httpBooks.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Text(".statusCode.toString()"),
        ),
      );
    }
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _getHttpBooks() async {
    httpBooks = await httpBookService.getHttpList();
  }
}
