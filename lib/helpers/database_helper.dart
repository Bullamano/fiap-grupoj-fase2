import 'dart:io';
import 'package:need_help/models/tutorial_item.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../models/tutorial_item.dart';

///Classe helper para ações com o DB
class DatabaseHelper {

  //Nomes de tabela e colunas
  static final table = 'tutorialItems';
  static final columnId = 'id';
  static final columnNome = 'nome';
  static final columnMateriais = 'materiais';
  static final columnPassos = 'passos';
  static final columnUrlFoto = 'urlFoto';
  static final columnCategoria = 'categoria';
  static final columnCreatedAt = 'createdAt';

  ///Método de abertura e criação do banco
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'needhelpdatabase.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        return await createTables(database);
      },
    );
  }

  ///Criação de tabela
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $columnNome TEXT NOT NULL,
        $columnMateriais TEXT NOT NULL,
        $columnPassos TEXT NOT NULL,
        $columnUrlFoto TEXT NULL,
        $columnCategoria TEXT NULL,
        $columnCreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  ///Criação de item
  static Future<int?> createItem(TutorialItem tutorialItem) async {
    final db = await DatabaseHelper.db();

    await db.insert(DatabaseHelper.table, tutorialItem.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return tutorialItem.id;
  }

  ///Recuperação de itens da tabela
  static Future<List<TutorialItem>> getItems() async {
    final data = await _getItemsDB();

    List<Map<String, dynamic>> _items = [];
    _items = data;

    return List.generate(_items.length, (index) {
      return TutorialItem(
          id: _items[index]['id'],
          nome: _items[index]['nome'],
          materiais: _items[index]['materiais'],
          passos: _items[index]['passos'],
          urlFoto: _items[index]['urlFoto'],
          categoria: _items[index]['categoria']);
    });
  }

  ///Método privado intermediário para recuperação de itens
  static Future<List<Map<String, dynamic>>> _getItemsDB() async {
    final db = await DatabaseHelper.db();
    return db.query(DatabaseHelper.table, orderBy: DatabaseHelper.columnId);
  }

  ///Recuperação de um item específico por ID
  static Future<List<TutorialItem>> getItem(int id) async {
    final data = await _getItemDB(id);

    List<Map<String, dynamic>> _item = [];
    _item = data;

    return List.generate(_item.length, (index) {
      return TutorialItem(
          id: _item[index]['id'],
          nome: _item[index]['nome'],
          materiais: _item[index]['materiais'],
          passos: _item[index]['passos'],
          urlFoto: _item[index]['urlFoto'],
          categoria: _item[index]['categoria']);
    });
  }

  ///Método privado intermediário para recuperação de itens específicos por ID
  static Future<List<Map<String, dynamic>>> _getItemDB(int id) async {
    final db = await DatabaseHelper.db();
    return db.query(DatabaseHelper.table, where: "id = ?", whereArgs: [id], limit: 1);
  }

  ///Recuperação de itens por um valor de categoria
  static Future<List<TutorialItem>> getByCategory(String category) async {
    final data = await _getByCategory(category);

    List<Map<String, dynamic>> _items = [];
    _items = data;

    return List.generate(_items.length, (index) {
      return TutorialItem(
          id: _items[index]['id'],
          nome: _items[index]['nome'],
          materiais: _items[index]['materiais'],
          passos: _items[index]['passos'],
          urlFoto: _items[index]['urlFoto'],
          categoria: _items[index]['categoria']);
    });
  }

  ///Método privado intermediário para recuperação de itens por sua categoria
  static Future<List<Map<String, dynamic>>> _getByCategory(String category) async {
    final db = await DatabaseHelper.db();
    return db.query(DatabaseHelper.table, where: "categoria = ?", whereArgs: [category]);
  }

  ///Modificação de registro
  static Future<int> updateItem(TutorialItem tutorialItem) async {
    final db = await DatabaseHelper.db();

    final result = await db.update(DatabaseHelper.table, tutorialItem.toMap(),
        where: "id = ?", whereArgs: [tutorialItem.id]);
    return result;
  }

  ///Delete de registro
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete(DatabaseHelper.table, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
