import 'package:Watchlist/models/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DataCacheProvider {
  Database? db;

  Future initialiseDatabase() async {
    var databasePath = await getDatabasesPath();

    db = await openDatabase(join(databasePath, 'project.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
           create table data (
           mediaType text not null,
           id integer primary key,
           title text not null,
           date text not null,
           adult text not null,
           imageUrl text not null,
           genres text not null,
           overview text not null,
           properties text );
         ''');
         print("data Table created");

         await db.execute('''
         create table characters (
          userId INTEGER PRIMARY KEY,
          genre INTEGER,
          name TEXT,
          characters TEXT,
          profile_path TEXT,
          idProperties INTEGER );
         ''');
         print("characters Table created");
    });
  }


  Future insert(Data data) async {
    await initialiseDatabase();
    await db!.insert('data', data.toJsonDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    data.properties['characters'] != null 
    ? data.properties['characters'].forEach((element) async {
      Characters character = new Characters.fromJson(element);
      await db!.insert('characters', character.toJsonDatabaseCharacters(data),
        conflictAlgorithm: ConflictAlgorithm.replace);
    })
    : '';

    var listAuthor = data.properties['authorName'] != null ? data.properties['authorName'].replaceAll('[', '').replaceAll(']', '').split(',') : null;
    if(data.properties['authorName'] != null){
      for(var i = 0; i < listAuthor.length; i++){
      Characters character = new Characters.fromJsonBook(listAuthor[i]);
      await db!.insert('characters', character.toJsonDatabaseCharacters(data),
        conflictAlgorithm: ConflictAlgorithm.replace);
        };
    }
  }

  Future<List<Data>> getAll() async {
    await initialiseDatabase();
    var result = await db!.query('data');
    var result2 = await db!.query('characters');
    var resultatFinalCharactere = result2.map((e) => Characters.fromJson(e)).toList();
    var resultatFinal=  result.map((e) => Data.fromJsonCache(e)).toList();
    resultatFinal.forEach((elementD) {
      resultatFinalCharactere.forEach((elementC) {
        if(elementD.id==elementC.idProperties){
          elementD.properties['personnages'].add(elementC);
        }
      });
    });
    return resultatFinal;
  }

  Future deleteAll() async {
    await initialiseDatabase();
    await db!.rawDelete('DELETE FROM data ');
    await db!.rawDelete('DELETE FROM characters ');
  }
}
