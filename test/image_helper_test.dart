import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:need_help/design_system/strings.dart';
import 'package:need_help/helpers/image_helper.dart';
import 'package:need_help/models/tutorial_item.dart';

///Testes relacionados a ImageHelper (image_helper.dart)
void main() {

  ///Teste: checkImageUrl
  test('checkImageUrl', () {
    //Teste com string de URL presente
    String expectedUrl = '123456';
    TutorialItem tutorialItem = TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: expectedUrl,
      categoria: 'categoria',
    );
    String result = ImageHelper.checkImageUrl(tutorialItem);
    expect(result, expectedUrl);

    //Teste sem string de URL
    TutorialItem tutorialItemNull = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: null,
      categoria: 'categoria',
    );
    String resultNull = ImageHelper.checkImageUrl(tutorialItemNull);

    expect(resultNull, kQuestionMarkUrl);
  });

  ///Teste: checkUrlForImage
  test('checkUrlForImage', () {
    //Teste com string de URL presente
    String url = '123456';
    String result = ImageHelper.checkUrlForImage(url);
    expect(result, url);

    //Teste sem string de URL
    String resultNull = ImageHelper.checkUrlForImage(null);
    expect(resultNull, kQuestionMarkUrl);
  });

  ///Teste: circleAvatarBasedOnImage
  test('circleAvatarBasedOnImage', () {
    TutorialItem tutorialItem = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: 'urlFoto',
      categoria: 'categoria',
    );
    Widget widget = ImageHelper.circleAvatarBasedOnImage(tutorialItem);

    expect(widget.runtimeType, CircleAvatar().runtimeType);

    TutorialItem tutorialItemNull = const TutorialItem(
      nome: 'nome',
      materiais: 'materiais',
      passos: 'passos',
      urlFoto: null,
      categoria: 'categoria',
    );
    Widget widgetNull = ImageHelper.circleAvatarBasedOnImage(tutorialItemNull);

    expect(widgetNull.runtimeType, CircleAvatar().runtimeType);

    //Os comentários abaixo foram mantidos caso deseje-se verificar seus objetos
    //print(widget.runtimeType);
    //print(widgetNull.runtimeType);
  });

}
