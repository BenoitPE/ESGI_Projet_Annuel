import 'package:flutter_project_test/models/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class UserCacheProvider {
  Database? db;

  Future initialiseDatabase() async {
    var databasePath = await getDatabasesPath();

    db = await openDatabase(join(databasePath, 'dbuser.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table users (
        idUser integer primary key,
        username text not null,
        email text not null, 
        password text not null)
      ''');
    });
  }

  Future<User> insert(User user) async {
    await initialiseDatabase();
    var newId = await db!.insert('users', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return User(
        idUser: newId,
        username: user.username,
        email: user.email,
        password: user.password);
  }

  Future<User> delete(User user) async {
    await initialiseDatabase();
    var newId = await db!.rawDelete('DELETE FROM users WHERE idUser = ?', [user.idUser]);
    return User(
        idUser: newId,
        username: user.username,
        email: user.email,
        password: user.password);
  }

  Future<List<User>> getAll() async {
    await initialiseDatabase();
    var result = await db!.query('users');
    return result.map((e) => User.fromJson(e)).toList();
  }
}
