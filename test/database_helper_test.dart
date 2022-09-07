import 'package:flutter_test/flutter_test.dart';
import 'package:need_help/design_system/initial_tutorial_items.dart';
import 'package:need_help/helpers/database_helper.dart';
import 'package:need_help/helpers/tutorial_item_persistence_helper.dart';
import 'package:need_help/models/tutorial_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

///Testes relacionados a DatabaseHelper (database_helper.dart)
void main() {
  ///Setup com sqflite_ffi para mock do sqflite
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

  ///Teste: Abertura do banco
  test('Opening DB', () async {
    var db = await DatabaseHelper.db();

    expect(db.isOpen, true);
    expect(db.path, ('${await getDatabasesPath()}\\needhelpdatabase.db'));
    expect(await db.getVersion(), 1);
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

  ///Teste: Nomes da tabela e suas colunas
  test('Names: table, columns, etc.', () {
    expect(DatabaseHelper.table, 'tutorialItems');
    expect(DatabaseHelper.columnId, 'id');
    expect(DatabaseHelper.columnNome, 'nome');
    expect(DatabaseHelper.columnMateriais, 'materiais');
    expect(DatabaseHelper.columnPassos, 'passos');
    expect(DatabaseHelper.columnUrlFoto, 'urlFoto');
    expect(DatabaseHelper.columnCategoria, 'categoria');
    expect(DatabaseHelper.columnCreatedAt, 'createdAt');
  });

  ///Teste: Criando um objeto no DB e recuperando-o
  test('Creating an object and getting an object', () async {
    TutorialItem tutorialItem = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: 'urlFoto',
      categoria: 'categoriaExemploDeTeste',
    );

    DatabaseHelper.createItem(tutorialItem);

    List<TutorialItem> tutorialItemQuery = await DatabaseHelper.getByCategory('categoriaExemploDeTeste');

    expect(tutorialItemQuery[0].nome.toString(), tutorialItem.nome.toString());
    expect(tutorialItemQuery[0].materiais.toString(), tutorialItem.materiais.toString());
    expect(tutorialItemQuery[0].passos.toString(), tutorialItem.passos.toString());
    expect(tutorialItemQuery[0].urlFoto.toString(), tutorialItem.urlFoto.toString());
    expect(tutorialItemQuery[0].categoria.toString(), tutorialItem.categoria.toString());

    List<TutorialItem> tutorialItemQuerySpecific = await DatabaseHelper.getItem(tutorialItemQuery[0].id as int);

    expect(tutorialItemQuerySpecific[0].nome.toString(), tutorialItem.nome.toString());
    expect(tutorialItemQuerySpecific[0].materiais.toString(), tutorialItem.materiais.toString());
    expect(tutorialItemQuerySpecific[0].passos.toString(), tutorialItem.passos.toString());
    expect(tutorialItemQuerySpecific[0].urlFoto.toString(), tutorialItem.urlFoto.toString());
    expect(tutorialItemQuerySpecific[0].categoria.toString(), tutorialItem.categoria.toString());

    expect(tutorialItemQuerySpecific[0].id.toString(),  tutorialItemQuery[0].id.toString());
  });

  ///Teste: deletando um objeto no DB
  test('Deleting an object and getting an object', () async {
    TutorialItem tutorialItem = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: 'urlFoto',
      categoria: 'categoriaExemploDeTeste',
    );

    DatabaseHelper.createItem(tutorialItem);

    List<TutorialItem> tutorialItemQuery = await DatabaseHelper.getByCategory('categoriaExemploDeTeste');

    DatabaseHelper.deleteItem(tutorialItemQuery[0].id as int);

    List<TutorialItem> tutorialItemQueryAfterDelete = await DatabaseHelper.getItem(tutorialItemQuery[0].id as int);

    expect(tutorialItemQueryAfterDelete, []);
  });
}
