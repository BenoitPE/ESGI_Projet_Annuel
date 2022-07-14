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
  final int idUser ;
  final String username;
  final String email ;
  final String password;

  User ({
    required this.idUser,
    required this.username,
    required this.email,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // return User(
    //   idUser: json['idUser'],
    //   username: json['username'],
    //   email: json['email'],
    //   password: json['password'],
    // );
    int idUser = json['idUser'];
    String username = json['username'];
    String email = json['email'];
    String password = json['password'];
    return User(
        idUser: idUser, username: username, email: email, password: password);
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

enum MediaType { Movie, Anime, Book, Serie, Tous }
