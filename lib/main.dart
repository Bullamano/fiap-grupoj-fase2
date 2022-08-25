// main.dart
import 'package:flutter/material.dart';
import 'package:need_help/screens/home_screen.dart';
import 'package:need_help/screens/info_screen.dart';
import 'package:need_help/screens/tutorial_screen.dart';

/// Main
void main() {
  runApp(const MyNeedHelpApp());
}

/// Classe principal com rotas para telas
class MyNeedHelpApp extends StatelessWidget {
  const MyNeedHelpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Need Help App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        TutorialScreen.id: (context) => TutorialScreen(
            arguments: ModalRoute.of(context)?.settings.arguments
                as TutorialScreenArguments),
        InfoScreen.id: (context) => InfoScreen()
      },
    );
  }
}
