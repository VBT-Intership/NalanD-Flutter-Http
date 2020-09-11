import 'dart:convert';
import 'dart:io';

import 'package:html_books_example/http_books/model/base_model.dart';
import 'package:html_books_example/http_books/model/error_model.dart';
import 'package:html_books_example/http_books/model/http_book_model.dart';
import 'package:html_books_example/http_books/service/IHttpBookService.dart';
import 'package:http/http.dart' as http;

class HttpBookService extends IHttpBookService {
  final baseUrl = "https://httpservice-6ccd7.firebaseio.com";

  @override
  Future<List<HttpBookModel>> getHttpList() async {
    return await _httpGet<HttpBookModel>(
        "$baseUrl/books.json", HttpBookModel());
  }

  Future<dynamic> _httpGet<T extends BaseModel>(String path, T model) async {
    try {
      final response = await http.get(path);
      if (response is http.Response) {
        switch (response.statusCode) {
          case HttpStatus.ok:
            return _bodyParser<T>(response.body, model);
          default:
            return ErrorModel(response.body);
        }
      }
    } catch (e) {
      throw ErrorModel("Error");
    }
  }

  dynamic _bodyParser<T extends BaseModel>(String body, BaseModel model) {
    final jsonBody = jsonDecode(body);
    if (jsonBody is List) {
      return jsonBody.map((e) => model.fromJson(e)).cast<T>().toList();
    } else if (jsonBody is Map) {
      return model.fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  }
}
