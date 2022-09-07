import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:need_help/design_system/widgets/category_button.dart';
import 'package:need_help/design_system/widgets/circular_tutorial_button.dart';
import 'package:need_help/design_system/widgets/custom_list_title.dart';
import 'package:need_help/design_system/widgets/editable_text_field.dart';
import 'package:need_help/design_system/widgets/save_rounded_button.dart';

///Testes relacionados aos Widgets da pasta de widgets:
///CategoryButton, CircularTutorialButton, CustomListTitle,
///EditableTextField, SaveRoundedButton
void main() {
  ///Teste: Botão de categoria
  testWidgets('CategoryButton', (WidgetTester tester) async {
    var stringToTestCategory = null;

    await tester.pumpWidget(CategoryButton(
        text: 'textButton',
        onPressed: () {
          stringToTestCategory = 'CategoryButton: Texto de teste';
        }));

    expect(find.text('textButton'), findsOneWidget);
    expect(find.text('testeBotao'), findsNothing);

    await tester.tap(find.text('textButton'));
    expect(stringToTestCategory, isNotNull);
    expect(stringToTestCategory, 'CategoryButton: Texto de teste');
  });

  ///Teste: CircularTutorialButton
  testWidgets('CircularTutorialButton', (WidgetTester tester) async {
    var stringToTestCircular = null;

    await tester.pumpWidget(CircularTutorialButton(
        innerWidget: const Text('textFromButton'),
        onPressed: () {
          stringToTestCircular = 'CircularTutorialButton: Texto de teste';
        }));

    expect(find.text('textFromButton'), findsOneWidget);
    expect(find.text('testeBotao'), findsNothing);

    await tester.tap(find.text('textFromButton'));
    expect(stringToTestCircular, isNotNull);
    expect(stringToTestCircular, 'CircularTutorialButton: Texto de teste');
  });

  ///Teste: CustomListTitle
  testWidgets('CustomListTitle', (WidgetTester tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: new MediaQueryData(),
        child: const MaterialApp(
          home: CustomListTitle(text: 'textFromList'),
        ),
      ),
    );

    expect(find.text('textFromList'), findsOneWidget);
    expect(find.text('testeLista'), findsNothing);
  });

  ///Teste: EditableTextField
  testWidgets('EditableTextField', (WidgetTester tester) async {
    var testController = TextEditingController();

    await tester.pumpWidget(MaterialApp(
      home: EditableTextField(
        tutorialLabelText: 'tutorialLabelTextTest',
        tutorialHelperText: 'tutorialHelperTextTest',
        textController: testController,
      ),
    ));

    expect(find.text('tutorialLabelTextTest'), findsOneWidget);
    expect(find.text('tutorialLabelTextTestando'), findsNothing);

    expect(find.text('tutorialHelperTextTest'), findsOneWidget);
    expect(find.text('tutorialHelperTextTestando'), findsNothing);

    await tester.enterText(
        find.byType(EditableTextField), 'Teste do EditableTextField');

    expect(testController.text, 'Teste do EditableTextField');
  });

  ///Teste: SaveRoundedButton
  testWidgets('SaveRoundedButton', (WidgetTester tester) async {
    var stringToTestRounded = null;

    await tester.pumpWidget(
      MediaQuery(
        data: new MediaQueryData(),
        child: MaterialApp(
          home: SaveRoundedButton(
              text: 'textSaveRoundedButton',
              onPressed: () {
                stringToTestRounded = 'SaveRoundedButton: Texto de teste';
              }),
        ),
      ),
    );

    expect(find.text('textSaveRoundedButton'), findsOneWidget);
    expect(find.text('textSaveRoundedButtones'), findsNothing);

    await tester.tap(find.text('textSaveRoundedButton'));
    expect(stringToTestRounded, isNotNull);
    expect(stringToTestRounded, 'SaveRoundedButton: Texto de teste');
  });
}
