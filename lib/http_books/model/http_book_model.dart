import 'package:html_books_example/http_books/model/base_model.dart';

class HttpBookModel extends BaseModel<HttpBookModel> {
  String image;
  String name;
  String writer;
  int year;

  HttpBookModel({this.image, this.name, this.writer, this.year});

  HttpBookModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    writer = json['writer'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['writer'] = this.writer;
    data['year'] = this.year;
    return data;
  }

  @override
  HttpBookModel fromJson(Map<String, Object> json) {
    return HttpBookModel.fromJson(json);
  }
}
