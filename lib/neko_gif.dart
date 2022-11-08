import 'json_serializable.dart';

class NekoGif {
  NekoGif(this.animeName, this.url);

  String animeName = '';
  String url = '';
}

class NekoGifSerializer implements JsonSerializer<NekoGif> {
  @override
  NekoGif fromJson(Map<String, dynamic> json) {
    return NekoGif(json[_animeNameTag], json[_urlTag]);
  }

  @override
  Map<String, dynamic> toJson(NekoGif value) {
    return {_animeNameTag: value.animeName, _urlTag: value.url};
  }

  static const String _animeNameTag = 'anime_name';
  static const String _urlTag = 'url';
}
