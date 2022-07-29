// main.dart
import 'package:flutter/material.dart';
import 'package:need_help/screens/home_screen.dart';
import 'package:need_help/screens/tutorial_screen.dart';

/// Main
void main() {
  runApp(const MyApp());
}

/// Classe principal com rotas para telas
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        TutorialScreen.id: (context) => TutorialScreen(
            arguments: ModalRoute.of(context)?.settings.arguments
                as TutorialScreenArguments),
      },
    );
  }
}
