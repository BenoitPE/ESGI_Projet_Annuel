class Data {
  final dynamic mediaType;
  final dynamic id;
  final dynamic title;
  final dynamic date;
  final dynamic adult;
  final dynamic imageUrl;
  final dynamic genres;
  final dynamic overview;
  final dynamic properties;

  const Data({
    this.mediaType,
    this.id,
    this.title,
    this.date,
    this.adult,
    this.imageUrl,
    this.genres,
    this.overview,
    this.properties
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      mediaType: json['mediaType'],
      id: json['id'],
      title: json['title'],
      date: json['date'],
      adult: json['adult'],
      imageUrl: json['imageUrl'],
      genres: json['genres'],
      overview: json['overview'],
      properties:json['properties']
    );
  }
}

class Media {
  final dynamic id;
  final dynamic title;
  final dynamic adult;
  final dynamic poster_path;
  final dynamic release_date;
  final dynamic genres;
  final dynamic credits;
  final dynamic overview;
  final dynamic videos;
  final MediaType? type;
  final dynamic imageUrl;
  final dynamic date;
  final dynamic trailerUrl;

  const Media(
      {required this.id,
      required this.title,
      required this.adult,
      required this.poster_path,
      required this.release_date,
      required this.genres,
      required this.credits,
      required this.overview,
      required this.videos,
      this.type,
      required this.imageUrl,
      required this.date,
      required this.trailerUrl});

  factory Media.fromJson(Map<String, dynamic> json, MediaType type) {
    return Media(
      id: json['id'],
      title: json['title'],
      adult: json['adult'],
      poster_path: json['poster_path'],
      release_date: json['release_date'],
      genres: json['genres'],
      credits: json['credits'],
      overview: json['overview'],
      videos: json['videos'],
      type: type,
      imageUrl: json['imageUrl'],
      date: json['date'],
      trailerUrl: json['trailerUrl'],
    );
  }
}

enum MediaType { Movie, Anime, Book, Serie, Tous }
