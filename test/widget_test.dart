import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:need_help/design_system/widgets/category_button.dart';
import 'package:need_help/main.dart';

///Testes relacionados aos Widgets da pasta de widgets:
///CategoryButton, CircularTutorialButton, CustomListTitle,
///EditableTextField, SaveRoundedButton
void main() {

  ///Teste: Botão de categoria
  testWidgets('CategoryButton', (WidgetTester tester) async {
    var stringToTest = null;

    await tester.pumpWidget(CategoryButton(
        text: 'textButton',
        onPressed: () {
          stringToTest = 'CategoryButton: Texto de teste';
        }));

    expect(find.text('textButton'), findsOneWidget);
    expect(find.text('testeBotao'), findsNothing);

    await tester.tap(find.text('textButton'));
    expect(stringToTest, isNotNull);
    expect(stringToTest, 'CategoryButton: Texto de teste');
  });

  //TODO: testes de outros widgets da pasta "widgets" e testes de interface completos
}
