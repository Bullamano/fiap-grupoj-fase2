import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///Argumentos para as telas de tutoriais
class TutorialScreenArguments {

  TutorialScreenArguments({
    required this.nome,
    required this.materiais,
    required this.passos,
    required this.urlFoto,
    required this.categoria,
  });

  String nome;
  String materiais;
  String passos;
  String urlFoto;
  String categoria;

}

///Telas de tutoriais com informações vindas do banco
class TutorialScreen extends StatelessWidget {
  static const id = 'tutorial_screen';

  const TutorialScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  ///Argumentos necessários para a tela
  final TutorialScreenArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.lightGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO: Parte de dentro da tela recebendo as variáveis
            ],
          ),
        ),
      ),
    );
  }
}