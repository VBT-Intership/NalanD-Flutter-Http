import 'package:html_books_example/http_books/model/http_book_model.dart';

abstract class IHttpBookService {
  Future<List<HttpBookModel>> getHttpList();
}
