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

  Map<String, dynamic> toJson() {
    return {
      'mediaType': mediaType,
      'id': id,
      'title': title,
      'date': date,
      'adult': adult,
      'imageUrl': imageUrl,
      'genres': genres,
      'overview': overview,
      'properties': properties,
    };
  }
}

class User {
  final dynamic idUser ;
  final dynamic username;
  final dynamic email ;
  final dynamic password;

  const User ({
    this.idUser,
    this.username,
    this.email,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['idUser'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}

enum MediaType { Movie, Anime, Book, Serie, Tous }
