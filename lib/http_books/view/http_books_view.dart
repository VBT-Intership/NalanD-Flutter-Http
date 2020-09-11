import 'package:flutter/material.dart';
import 'package:html_books_example/http_books/model/error_model.dart';
import 'package:html_books_example/http_books/model/http_book_model.dart';
import '../viewModel/http_books_view_model.dart';

class HttpBooksView extends HttpBooksViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildFutureBuilder(),
      // body: ListView.builder(
      //     padding: EdgeInsets.all(5),
      //     itemCount: httpBooks.length,
      //     itemBuilder: (context, index) => buildCardHttp(httpBooks[index])),
    );
  }

  FutureBuilder<List<HttpBookModel>> buildFutureBuilder() {
    return FutureBuilder<List<HttpBookModel>>(
        future: httpBookService.getHttpList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<HttpBookModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                return buildListViewHttp(snapshot.data);
              } else {
                final error = snapshot.error as ErrorModel;
                return Center(
                  child: Text(error.text),
                );
              }
              break;
            default:
              return Text("Something went wrong");
          }
        });
  }

  ListView buildListViewHttp(List<HttpBookModel> httpBooks) {
    return ListView.builder(
      // padding: EdgeInsets.all(5),
      itemCount: httpBooks.length,
      itemBuilder: (context, index) => buildCardHttp(httpBooks[index]),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: buildTextAppBar(),
      leading: buildPaddingProgress,
    );
  }

  Card buildCardHttp(HttpBookModel book) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(20),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: buildContainerImage(book),
        subtitle: buildPaddingSubtitle(book),
      ),
    );
  }

  Container buildContainerImage(HttpBookModel book) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Image.network(book.image)));
  }

  Padding buildPaddingSubtitle(HttpBookModel book) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              book.name,
              style: TextStyle(
                color: Colors.orange[300],
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              book.writer,
              style: TextStyle(
                color: Colors.green[300],
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              book.year.toString(),
              style: TextStyle(
                color: Colors.red[300],
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }

  Text buildTextAppBar() => Text("Http Books Example");

  Widget get buildPaddingProgress {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: isLoading,
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.3),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
