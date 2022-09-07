import 'package:flutter_test/flutter_test.dart';
import 'package:need_help/helpers/database_helper.dart';
import 'package:need_help/helpers/tutorial_item_persistence_helper.dart';
import 'package:need_help/models/tutorial_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

///Testes relacionados a TutorialItemPersistenceHelper (tutorial_item_persistence_helper.dart)
void main() {
  ///Setup com sqflite_ffi para mock do sqflite
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

  ///Teste: Conteúdo do banco
  test('Database initial contents', () async {
    TutorialItemPersistenceHelper.initialAddItem();

    var data = await DatabaseHelper.getItems();
    expect(data, isNotNull);

    //O id é adicionado como null devido ao mock do banco
    TutorialItem tutorialItem = TutorialItem(
      id: 1,
      nome: data[0].nome,
      materiais: data[0].materiais,
      passos: data[0].passos,
      urlFoto: data[0].urlFoto,
      categoria: data[0].categoria,
    );
    expect(data[0].toString(), tutorialItem.toString());
  });

  ///Teste: Criando um objeto no DB e recuperando-o
  test('Creating an object and getting an object', () async {
    TutorialItemPersistenceHelper.addItem(
        'nome', 'materiais', 'passos', 'urlFoto', 'categoriaTesteTut');

    TutorialItem tutorialItem = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: 'urlFoto',
      categoria: 'categoriaTesteTut',
    );
    TutorialItemPersistenceHelper.addTutorialItem(tutorialItem);

    List<TutorialItem> tutorialItemQuery =
        await DatabaseHelper.getByCategory('categoriaTesteTut');

    TutorialItem searchedTutorialItem = await TutorialItemPersistenceHelper.getTutorialItem(tutorialItemQuery[0].id as int);

    expect(tutorialItemQuery[0].id.toString(), searchedTutorialItem.id.toString());
    expect(tutorialItemQuery[0].nome.toString(), searchedTutorialItem.nome.toString());
    expect(tutorialItemQuery[0].materiais.toString(),searchedTutorialItem.materiais.toString());
    expect(tutorialItemQuery[0].passos.toString(), searchedTutorialItem.passos.toString());
    expect(tutorialItemQuery[0].urlFoto.toString(),searchedTutorialItem.urlFoto.toString());
    expect(tutorialItemQuery[0].categoria.toString(),searchedTutorialItem.categoria.toString());
  });

  ///Teste: deletando um objeto no DB
  test('Deleting an object and getting an object', () async {
    TutorialItem tutorialItem = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: 'urlFoto',
      categoria: 'categoriaDeTesteTutDelete',
    );

    DatabaseHelper.createItem(tutorialItem);

    List<TutorialItem> tutorialItemQuery =
        await DatabaseHelper.getByCategory('categoriaDeTesteTutDelete');

    TutorialItemPersistenceHelper.deleteItem(tutorialItemQuery[0].id as int);

    List<TutorialItem> tutorialItemQueryAfterDelete =
    await DatabaseHelper.getByCategory('categoriaDeTesteTutDelete');

    expect(tutorialItemQueryAfterDelete, []);
  });
}
