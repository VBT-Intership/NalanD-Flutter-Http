import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html_albums_example/http_albums/model/http_album_model.dart';
import '../view/http_albums.dart';
import 'package:http/http.dart' as http;

abstract class HttpAlbumsViewModel extends State<HttpAlbums> {
  final baseUrl = "https://rallycoding.herokuapp.com";
  bool isLoading = false;
  List<HttpAlbumModel> httpAlbums = [];

  @override
  void initState() {
    super.initState();
    callItems();
  }

  Future<void> callItems() async {
    changeLoading();
    await _getHttpAlbums();
    changeLoading();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _getHttpAlbums() async {
    final response = await http.get("$baseUrl/api/music_albums");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body);
        if (jsonBody is List) {
          httpAlbums = jsonBody.map((e) => HttpAlbumModel.fromJson(e)).toList();
        }
        break;
      default:
    }
  }
}
