import 'package:flutter/foundation.dart';
import 'package:need_help/design_system/initial_tutorial_items.dart';
import '../models/tutorial_item.dart';
import 'database_helper.dart';

///Classe helper para persistência de itens de tutorial
class TutorialItemPersistenceHelper {

  ///Método para inserir um item novo no banco através de suas propriedades
  static Future<void> addItem(
    String nome,
    String materiais,
    String passos,
    String? urlFoto,
    String? categoria,
  ) async {
    if (kDebugMode) {
      print('Adding item $nome to database');
    }

    TutorialItem tutorialItem = TutorialItem(
        nome: nome,
        materiais: materiais,
        passos: passos,
        urlFoto: urlFoto,
        categoria: categoria);
    await addTutorialItem(tutorialItem);

    //print('Insert: done');
  }

  ///Método para inserir um TutorialItem novo no banco
  static Future<void> addTutorialItem(TutorialItem tutorialItem) async {
    await DatabaseHelper.createItem(tutorialItem);
  }

  ///Método de adição inicial de itens no banco (para quando não houver
  ///nada no banco)
  static Future<void> initialAddItem() async {

    if (kDebugMode) {
      print('Adding initial items');
    }

    addTutorialItem(kLasagnaTutorialItem);
    addTutorialItem(kAmarrarSapatoTutorialItem);
    addTutorialItem(kAbrirOlhosTutorialItem);
    addTutorialItem(kVoarTutorialItem);
    addTutorialItem(kTutorialTutorialItem);
    addTutorialItem(kPiTutorialItem);
    addTutorialItem(kRespirarTutorialItem);
    addTutorialItem(kLoteriaTutorialItem);
    addTutorialItem(kRicoTutorialItem);
    addTutorialItem(kLife1TutorialItem);
    addTutorialItem(kLife2TutorialItem);
    addTutorialItem(kLife3TutorialItem);
    addTutorialItem(kLife4TutorialItem);
    addTutorialItem(kLife5TutorialItem);
    addTutorialItem(kLife6TutorialItem);
    addTutorialItem(kLife7TutorialItem);
    addTutorialItem(kLife8TutorialItem);
    addTutorialItem(kLife9TutorialItem);
    addTutorialItem(kLife10TutorialItem);
    addTutorialItem(kLife11TutorialItem);
  }

  ///Método para atualizar uma entrada no banco através de suas propriedades
  static Future<void> updateItem(
    int id,
    String nome,
    String materiais,
    String passos,
    String? urlFoto,
    String? categoria,
  ) async {
    if (kDebugMode) {
      print('Updating item $id');
    }

    TutorialItem tutorialItem = TutorialItem(
        nome: nome,
        materiais: materiais,
        passos: passos,
        urlFoto: urlFoto,
        categoria: categoria);
    await DatabaseHelper.updateItem(tutorialItem);
  }

  ///Método para atualizar um TutorialItem no banco
  static Future<void> updateTutorialItem(TutorialItem tutorialItem) async {
    await DatabaseHelper.updateItem(tutorialItem);
  }

  ///Método para deletar uma entrada do banco
  static void deleteItem(int id) async {
    if (kDebugMode) {
      print('Deleting item $id');
    }

    await DatabaseHelper.deleteItem(id);
  }
}
