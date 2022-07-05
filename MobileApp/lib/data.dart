class Data {
  final dynamic id;
  final dynamic label;
  final dynamic imageUrl;
  final dynamic date;
  final Media? anime;
  final Media? book;
  final Media? movie;
  final Media? serie;

  const Data({
    this.id,
    this.label,
    this.imageUrl,
    this.date,
    this.anime,
    this.book,
    this.movie,
    this.serie,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      label: json['title'],
      imageUrl: json['imageUrl'],
      date: json['date'],
      anime: json['anime'] == null
          ? null
          : Media.fromJson(json['anime'], MediaType.Anime),
      book: json['book'] == null
          ? null
          : Media.fromJson(json['book'], MediaType.Book),
      movie: json['movie'] == null
          ? null
          : Media.fromJson(json['movie'], MediaType.Movie),
      serie: json['serie'] == null
          ? null
          : Media.fromJson(json['serie'], MediaType.Serie),
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

class Movie {
  final int id;
  final String title;
  final String adult;
  final String poster_path;
  final String release_date;
  final List<Genre> genre;
  final List<Credits> credis;
  final String overview;
  final List<Results> video;

  const Movie({
    required this.id,
    required this.title,
    required this.adult,
    required this.poster_path,
    required this.release_date,
    required this.genre,
    required this.credis,
    required this.overview,
    required this.video,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      adult: json['adult'],
      poster_path: json['poster_path'],
      release_date: json['release_date'],
      genre: json['genre'],
      credis: json['credis'],
      overview: json['overview'],
      video: json['video'],
    );
  }
}

class Genre {
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Credits {
  final int id;
  final List<Cast> cast;

  const Credits({
    required this.id,
    required this.cast,
  });

  factory Credits.fromJson(Map<String, dynamic> json) {
    return Credits(
      id: json['id'],
      cast: json['cast'],
    );
  }
}

class Cast {
  final String character;
  final String profil_path;
  final int id;
  final String gender;
  final String name;
  final String imageUrl;

  const Cast({
    required this.character,
    required this.profil_path,
    required this.id,
    required this.gender,
    required this.name,
    required this.imageUrl,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      character: json['character'],
      profil_path: json['profil_path'],
      id: json['id'],
      gender: json['gender'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}

class Results {
  final String name;
  final dynamic key;
  final dynamic trailerUrl;

  const Results({required this.name, this.key, this.trailerUrl});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      name: json['name'],
      key: json['key'],
      trailerUrl: json['trailerUrl'],
    );
  }
}
