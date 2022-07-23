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

  const Data(
      {this.mediaType,
      this.id,
      this.title,
      this.date,
      this.adult,
      this.imageUrl,
      this.genres,
      this.overview,
      this.properties});

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
        properties: json['properties']);
  }

  factory Data.fromJsonCache(Map<String, dynamic> json) {
    var properties = Map<String, dynamic>();
    properties['personnages']= <Characters> [];
    properties['trailerUrl']= json['properties'] != null? json['properties']:'';
    return Data(
        mediaType: json['mediaType'],
        id: json['id'],
        title: json['title'],
        date: json['date'],
        adult: json['adult'],
        imageUrl: json['imageUrl'],
        genres: json['genres'],
        overview: json['overview'],
        properties: properties
        );
  }

  Map<String, dynamic> toJsonDatabase() {
    return {
      'mediaType': mediaType,
      'id': id,
      'title': title,
      'date': date,
      'adult': adult.toString(),
      'imageUrl': imageUrl,
      'genres': "",
      'overview': overview,
      'properties': properties['trailerUrl'],
    };
  }
}

class Characters {
  final dynamic gender;
  final dynamic name;
  final dynamic character;
  final dynamic imageUrl;
  final dynamic idProperties;

  Characters({this.gender, this.character, this.name, this.imageUrl, this.idProperties});

  factory Characters.fromJson(Map<String, dynamic> json) {
    dynamic gender = (json['genre']!= null ? json['genre'] :'');
    dynamic character = (json['characters'] != null ? json['characters'] :json['characters'] != null ? json['authorName'] :'');
    dynamic name = (json['name'] != null ? json['name']  :'');
    dynamic imageUrl = (json['profile_path'] != null ? json['profile_path'] :'');
    dynamic idProperties = (json['idProperties'] != null ? json['idProperties'] :'');
    return Characters(
        gender: gender,
        character: character,
        name: name,
        imageUrl: imageUrl,
        idProperties: idProperties );
  }

  factory Characters.fromJsonBook(String authorName) {
    dynamic gender = '';
    dynamic character = '';
    dynamic name = authorName ;
    dynamic imageUrl = '';
    dynamic idProperties ='';
    return Characters(
        gender: gender,
        character: character,
        name: name,
        imageUrl: imageUrl,
        idProperties: idProperties );
  }

  Map<String, dynamic> toJsonDatabaseCharacters(dynamic element) {
    return {
      'genre': gender,
      'characters': character,
      'name': name,
      'profile_path': imageUrl,
      'idProperties' : element.id
    };
  }
}

class User {
  final int idUser;
  final String username;
  final String email;
  final String password;

  User(
      {required this.idUser,
      required this.username,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
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
