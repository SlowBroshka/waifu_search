import 'json_serializable.dart';

class NekoImage {
  NekoImage(this.artistRef, this.artistName, this.sourceUrl, this.url);

  String artistRef = '';
  String artistName = '';
  String sourceUrl = '';
  String url = '';
}

class NekoImageSerializer implements JsonSerializer<NekoImage> {
  @override
  NekoImage fromJson(Map<String, dynamic> json) {
    return NekoImage(json[_artistRefTag], json[_artistNameTag],
        json[_sourceUrlTag], json[_urlTag]);
  }

  @override
  Map<String, dynamic> toJson(NekoImage value) {
    return {
      _artistRefTag: value.artistRef,
      _artistNameTag: value.artistName,
      _sourceUrlTag: value.sourceUrl,
      _urlTag: value.url
    };
  }

  static const String _artistRefTag = 'artist_href';
  static const String _artistNameTag = 'artist_name';
  static const String _sourceUrlTag = 'source_url';
  static const String _urlTag = 'url';
}
