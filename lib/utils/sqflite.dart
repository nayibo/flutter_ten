import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;
  static final String sql_create_table_favorite =
      " CREATE TABLE IF NOT EXISTS " +
          DBConstant.DB_TABLE_NAME_FAVORITE +
          " (" +
          " id INTEGER," +
          " type INTEGER," +
          " title VARCHAR, " +
          " summary VARCHAR," +
          " redundancy_1 INTEGER," // 冗余字段，未使用
          +
          " redundancy_2 INTEGER," // 冗余字段，未使用
          +
          " redundancy_3 VARCHAR," // 用作文章发布存储日期
          +
          " redundancy_4 VARCHAR," // 冗余字段，未使用
          +
          " constraint pk_t2 primary key (id,type)" +
          ")";

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DBConstant.DB_NAME);
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(sql_create_table_favorite);
  }

  Future<List<FavoriteBean>> getFavoriteList() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM ' + DBConstant.DB_TABLE_NAME_FAVORITE);
    List<FavoriteBean> favorites = new List();
    for (int i = 0; i < list.length; i++) {
      favorites.add(new FavoriteBean(
          id: list[i]['id'],
          type: list[i]['type'],
          title: list[i]['title'],
          summary: list[i]['summary'],
          publishtime: list[i]['redundancy_1']));
    }
    return favorites;
  }

  void insertFavorite(FavoriteBean favorite) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert('INSERT INTO ' +
          DBConstant.DB_TABLE_NAME_FAVORITE +
          '(id, type, title, summary, redundancy_1 ) VALUES(' +
          '\'' +
          favorite.id.toString() +
          '\'' +
          ',' +
          '\'' +
          favorite.type.toString() +
          '\'' +
          ',' +
          '\'' +
          favorite.title +
          '\'' +
          ',' +
          '\'' +
          favorite.summary +
          '\'' +
          ',' +
          '\'' +
          favorite.publishtime.toString() +
          '\'' +
          ')');
    });
  }

  Future<bool> isFavorite(String id, String type) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM ' + DBConstant.DB_TABLE_NAME_FAVORITE + " where id=" +
        id +
        " and type=" +
        type);
    return list != null && list.isNotEmpty;
  }

  void deleteFavorite(String id, String type) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawDelete('DELETE FROM ' +
          DBConstant.DB_TABLE_NAME_FAVORITE +
          " where id=" +
          id +
          " and type=" +
          type);
    });
  }
}
