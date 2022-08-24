import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_help/design_system/strings.dart';
import 'package:need_help/design_system/widgets/ListTitle_NeedHelp.dart';

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
              Container(
                child:
                  Image.asset('assets/images/questionmark.jpg',
                  ),
                // Image(
                //   image:NetworkImage(arguments?.urlFoto ?? kQuestionMarkUrl),
                // )
              ),
              SizedBox(height: 10,),
              ListTitle_NeedHelp(
                  text: 'Lalala um nome aqui'
              ),
              // Container(
              //   child:
              //   Text(
              //     arguments?.nome?? 'Nome indisponível'
              //   ),
              // ),
              SizedBox(height: 10,),
              ListTitle_NeedHelp(
                text: 'Materiais:',
              ),
              Container(
                child: Text('Lista Materiais lalala'),
              ),
              // Container(
              //   child:
              //   Text(
              //     arguments?.materiais ?? 'Materiais indisponíveis'
              //   ),
              // ),
              SizedBox(height: 20,),
              ListTitle_NeedHelp(
                text: 'Passo a Passo:',
              ),
              Container(
                child: Text('Lista Passo a Passo'),
              ),
              // Container(
              //   child:
              //   Text(
              //     arguments?.passos?? 'Passo a passo indisponível'
              //   ),
              // ),
              //TODO: Parte de dentro da tela recebendo as variáveis
            ],
          ),
        ),
      ),
    );
  }
}
