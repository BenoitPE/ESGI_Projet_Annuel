import 'package:flutter_project_test/models/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DataCacheProvider {
  Database? db;

  Future initialiseDatabase() async {

    void _onCreate(Database db, int version) async {
      await db.execute("CREATE TABLE characters("
          "userId INTEGER PRIMARY KEY AUTO_INCREMENT,"
          "genre INTEGER,"
          "name TEXT,"
          "characters TEXT,"
          "profile_path TEXT,"
          "idProperties INTEGER,"
          ")");
      print("User Table created");
    }
    
    var databasePath = await getDatabasesPath();

    db = await openDatabase(join(databasePath, 'dbdata.db'),
        version: 1, onCreate: _onCreate);
        ///(Database db, int version) async {
        //   await db.execute('''
        //   create table data (
        //   mediaType text not null,
        //   id integer primary key,
        //   title text not null,
        //   date text not null,
        //   adult text not null,
        //   imageUrl text not null,
        //   genres text not null,
        //   overview text not null,
        //   properties text );
        // ''');

        // await db.execute("CREATE TABLE characters ("
        //     "genre integer,"
        //     "name TEXT,"
        //     "characters TEXT primary key,"
        //     "profile_path TEXT,"
        //     "idProperties integer,"
        //     ")");

        //   await db.execute('''
        //   create table characters  P
        //   genre int not null,
        //   name integer not null,
        //   character text primary key,
        //   profile_path text not null,
        //   idProperties integer not null)
        // ''');
        //},

       // );

  }

  Future<Data> insert(Data data) async {
    await initialiseDatabase();
    //var newId = await db!.insert('data', data.toJsonDatabase(),conflictAlgorithm: ConflictAlgorithm.replace);
    data.properties['characters'].forEach((element) async {
      Characters characters = Characters.fromJson(element);
      await db!.insert('characters', characters.toJsonDatabaseCharacters(data),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
    return Data(
      mediaType: data.mediaType,
      id: data.id, //newId,
      title: data.title,
      date: data.date,
      adult: data.adult,
      imageUrl: data.imageUrl,
      genres: data.genres,
      overview: data.overview,
      properties: data.properties['trailerUrl'],
    );
  }

  Future delete() async {
    await initialiseDatabase();
    await db!.execute('DROP TABLE IF EXISTS data');
  }

  Future<List<Data>> getAll() async {
    await initialiseDatabase();
    var result = await db!.query('data');
    return result.map((e) => Data.fromJson(e)).toList();
  }
}
