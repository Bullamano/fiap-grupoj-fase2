import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {

  static final table = 'items';
  static final columnId = 'id';
  static final columnNome = 'nome';
  static final columnMateriais = 'materiais';
  static final columnPassos = 'passos';
  static final columnUrlFoto = 'urlfoto';
  static final columnCategoria = 'categoria';
  static final columnCreatedAt = 'createdAt';

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE $table(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnId INTEGER PRIMARY KEY,
        $columnNome TEXT NOT NULL,
        $columnMateriais TEXT NOT NULL,
        $columnPassos TEXT NOT NULL,
        $columnUrlFoto TEXT NULL,
        $columnCategoria TEXT NULL,
        $columnCreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'NeedHelpDB.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String nome,
                                String materiais,
                                String passos,
                                String? urlfoto,
                                String? categoria) async {
    final db = await DatabaseHelper.db();

    final data = {
      DatabaseHelper.columnNome: nome,
      DatabaseHelper.columnMateriais: materiais,
      DatabaseHelper.columnPassos: passos,
      DatabaseHelper.columnUrlFoto: urlfoto,
      DatabaseHelper.columnCategoria: categoria
    };

    final id = await db.insert(DatabaseHelper.table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query(DatabaseHelper.table, orderBy: DatabaseHelper.columnId);
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query(DatabaseHelper.table, where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id,
                                String nome,
                                String materiais,
                                String passos,
                                String? urlfoto,
                                String? categoria) async {
    final db = await DatabaseHelper.db();

    final data = {
      DatabaseHelper.columnNome: nome,
      DatabaseHelper.columnMateriais: materiais,
      DatabaseHelper.columnPassos: passos,
      DatabaseHelper.columnUrlFoto: urlfoto,
      DatabaseHelper.columnCategoria: categoria,
      DatabaseHelper.columnCreatedAt: DateTime.now().toString()
    };

    final result =
    await db.update(DatabaseHelper.table, data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete(DatabaseHelper.table, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}