import 'package:flutter/foundation.dart';
import 'package:waifu_searcher/api/image_category.dart';
import 'package:waifu_searcher/api/query_status.dart';
import 'package:waifu_searcher/json_serializable.dart';
import 'package:waifu_searcher/neko_image.dart';
import 'package:waifu_searcher/neko_gif.dart';
import '../api/api_const.dart';

import 'dart:io';
import 'dart:convert';

class UrlModel extends ChangeNotifier {
  late String _url = _defaultValue.url;
  QueryStatus _status = QueryStatus.unknown;
  final client = HttpClient();

  String get url => _url;
  QueryStatus get status => _status;

  void updateImg(ImageCategory category) async {
    NekoImage res = await _query(NekoImageSerializer(), category.name);
    _status = QueryStatus.loadingImage;
    _url = res.url;
    _status = QueryStatus.success;
    notifyListeners();
  }

  void updateGif(GifCategory category) async {
    NekoGif res = await _query<NekoGif>(NekoGifSerializer(), category.name);
    _status = QueryStatus.loadingImage;
    _url = res.url;
    _status = QueryStatus.success;
    notifyListeners();
  }

  Future<Type> _query<Type>(
      JsonSerializer<Type> serializer, String category) async {
    final uri = Uri.parse(_createQueryURL(category));
    final request = await client.getUrl(uri);
    final response = await request.close();
    // if (response.statusCode >= 300) {
    //   return ;
    // }
    final rawStr = await response.transform(utf8.decoder).toList();
    final resJson = jsonDecode(rawStr.join())['results'] as List;
    List<Type> list = resJson.map((json) => serializer.fromJson(json)).toList();
    Type res = list[0];

    return res;
  }

  String _createQueryURL(String category) {
    return APIConst.baseUrl + category;
  }

  static final NekoImage _defaultValue = NekoImageSerializer().fromJson({
    "artist_href": "https://www.pixiv.net/en/users/2151477",
    "artist_name": "およ",
    "source_url": "https://www.pixiv.net/en/artworks/99012532",
    "url": "https://nekos.best/api/v2/husbando/0054.png"
  });
}
