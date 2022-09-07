import 'package:flutter_test/flutter_test.dart';
import 'package:need_help/models/tutorial_item.dart';

///Testes relacionados a TutorialItem (tutorial_item.dart)
void main() {

  ///Teste: Criação de um objeto TutorialItem
  test('Create tutorial item', () {
    TutorialItem tutorialItem = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: 'urlFoto',
      categoria: 'categoria',
    );

    expect(tutorialItem.id, null);
    expect(tutorialItem.nome, 'nome');
    expect(tutorialItem.materiais, 'materiais');
    expect(tutorialItem.passos, 'passos');
    expect(tutorialItem.urlFoto, 'urlFoto');
    expect(tutorialItem.categoria, 'categoria');
  });

  ///Teste: ToString de um objeto TutorialItem
  test('Tutorial item to string', () {
    TutorialItem tutorialItem = const TutorialItem(
      id: 1234,
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: 'urlFoto',
      categoria: 'categoria',
    );

    String resultString = tutorialItem.toString();

    expect(resultString, 'TutorialItem{id: 1234, nome: nome, categoria: categoria}');
  });
}
