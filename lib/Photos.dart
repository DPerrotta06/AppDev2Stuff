
class Photos {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photos(
      {required this.albumId, required this.id, required this.title, required this.thumbnailUrl, required this.url});

  factory Photos.fromJson(Map<String, dynamic> json){
    return switch(json){
    {'albumId' : int albumId, 'id' : int id, 'title' : String title, 'url' : String url, 'thumbnailUrl' : String thumbnailUrl }
    => Photos(albumId: albumId, id: id, title: title, thumbnailUrl: thumbnailUrl, url: url) , _ => throw const FormatException('Failed to load album')
    };
  }
}