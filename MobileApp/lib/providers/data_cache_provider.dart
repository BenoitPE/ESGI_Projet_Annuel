import 'package:flutter_project_test/models/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DataCacheProvider {
  Database? db;

  Future initialiseDatabase() async {
    var databasePath = await getDatabasesPath();

    db = await openDatabase(join(databasePath, 'tpdata.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table data (
        mediaType text not null,
        id integer not null,
        title text not null, 
        date text not null,
        adult text not null,
        imageUrl text not null,
        genres text not null,
        overview text not null,
        properties text )
      ''');
    });
  }

  Future<Data> insert(Data data) async {
    await initialiseDatabase();
    //var newId = await db!.insert('data', data.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    return Data(
      mediaType: data.mediaType,
      id: data.id,
      title: data.title,
      date: data.date,
      adult: data.adult,
      imageUrl: data.imageUrl,
      genres: data.genres,
      overview: data.overview,
      properties: data.properties,);
  }

  Future<List<Data>> getAll() async {
    await initialiseDatabase();
    var result = await db!.query('data');
    return result.map((e) => Data.fromJson(e)).toList();
  }
}