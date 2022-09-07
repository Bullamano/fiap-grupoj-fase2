import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:need_help/design_system/widgets/save_rounded_button.dart';
import 'package:need_help/helpers/database_helper.dart';
import 'package:need_help/helpers/tutorial_item_persistence_helper.dart';
import 'package:need_help/models/tutorial_item.dart';
import 'package:need_help/screens/home_screen.dart';
import 'package:need_help/screens/info_screen.dart';
import 'package:need_help/screens/tutorial_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

///Testes relacionados aos Widgets da pasta de screens:
///HomeScreen, InfoScreen e TutorialScreen
void main() {
  ///Setup com sqflite_ffi para mock do sqflite
  setUpAll(() {
    //SQFlite_FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    //Retirando HTTP Overrides para não impedir o fetch de imagens
    HttpOverrides.global = null;
  });

  //Testes relacionados à HomeScreen não foram adicionados devido
  //a um bug conhecido com a SliverGeometry. Em tempo de execução,
  //o bug foi contornado mas isto impede os testes de interface
  //da mesma. O bug ocorre durante a construção da GridView, quando
  //eventualmente pode conter 0 itens. Isso faz com que ocorra um bug no widget.
  // Para mais informações acerca deste bug, siga os links abaixo:
  //https://stackoverflow.com/questions/64121352/error-slivergeometry-is-not-valid-the-scrollextent-is-negative-in-flutter-s
  //https://github.com/flutter/flutter/issues/39963

  ///Teste: HomeScreen (exemplo de teste simples com o botão de categoria)
  // testWidgets('HomeScreen', (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     const MediaQuery(
  //       data: MediaQueryData(),
  //       child: MaterialApp(
  //         home: HomeScreen(),
  //       ),
  //     ),
  //   );
  //
  //   expect(find.text('Comidas'), findsOneWidget);
  //   tester.tap(find.text('Comidas'));
  //
  //   expect(find.text('Como fazer lasagna'), findsOneWidget);
  //   expect(find.text('Como amarrar sapatos'), findsNothing);
  // });

  ///Teste: InfoScreen
  testWidgets('InfoScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: InfoScreen(),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('tituloField')), 'TituloTeste');
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key('materiaisField')), 'MateriaisTeste');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('passosField')), 'PassosTeste');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('urlField')), 'URLTeste');
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byKey(const Key('categoriaField')), 'CategoriaTeste');
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(find.byType(SaveRoundedButton),
        find.byType(SingleChildScrollView), const Offset(0, 50));
    await tester.tap(find.byType(SaveRoundedButton));
  });

  ///Teste: TutorialScreen
  testWidgets('TutorialScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: TutorialScreen(
              arguments: TutorialScreenArguments(
            nome: 'nomeTeste',
            materiais: 'materiaisTeste',
            passos: 'passosTeste',
            urlFoto: '',
            categoria: 'categoriaTeste',
          )),
        ),
      ),
    );

    expect(find.byKey(const Key('tituloTutorialItem')), findsOneWidget);
    expect(find.text('nomeTeste'), findsOneWidget);

    expect(find.byKey(const Key('materiaisTutorialItem')), findsOneWidget);
    expect(find.text('materiaisTeste'), findsOneWidget);

    expect(find.byKey(const Key('passosTutorialItem')), findsOneWidget);
    expect(find.text('passosTeste'), findsOneWidget);

  });
}
