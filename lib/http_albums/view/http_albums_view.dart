import 'package:flutter/material.dart';
import 'package:html_albums_example/http_albums/model/http_album_model.dart';
import '../viewModel/http_albums_view_model.dart';

class HttpAlbumsView extends HttpAlbumsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView.builder(
          padding: EdgeInsets.all(5),
          itemCount: httpAlbums.length,
          itemBuilder: (context, index) => buildCardHttp(httpAlbums[index])),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: buildTextAppBar(),
      leading: buildPaddingProgress,
    );
  }

  Card buildCardHttp(HttpAlbumModel album) {
    return Card(
      margin: EdgeInsets.all(20),
      child: ListTile(
        title: Image.network(album.image),
        subtitle: buildPaddingSubtitle(album),
      ),
    );
  }

  Padding buildPaddingSubtitle(HttpAlbumModel album) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        album.title,
        style: TextStyle(color: Colors.orange[300], fontSize: 20),
      ),
    );
  }

  Text buildTextAppBar() => Text("Http Albums Example");

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
          )),
    );
  }
}
