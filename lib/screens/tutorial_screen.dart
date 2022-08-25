import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:need_help/design_system/strings.dart';
import 'package:need_help/design_system/widgets/custom_list_title.dart';
import 'package:need_help/screens/home_screen.dart';

import '../design_system/colors.dart';
import '../helpers/image_helper.dart';
import '../helpers/tutorial_item_persistence_helper.dart';

///Argumentos para as telas de tutoriais
class TutorialScreenArguments {
  TutorialScreenArguments({
    this.id,
    required this.nome,
    required this.materiais,
    required this.passos,
    required this.urlFoto,
    required this.categoria,
  });

  int? id;
  String nome;
  String materiais;
  String passos;
  String urlFoto;
  String categoria;
}

///Telas de tutoriais com informações vindas do banco
class TutorialScreen extends StatelessWidget {
  static const id = 'tutorial_screen';

  ///Construtor
  const TutorialScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  ///Argumentos necessários para a tela
  final TutorialScreenArguments? arguments;

  ///Método para deletar uma entrada do banco
  void _deleteItem(int id, context) async {
    TutorialItemPersistenceHelper.deleteItem(id);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppThemeColor,
        title: Text(
          arguments?.nome ?? 'Nome indisponível',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,

      //Botão para deletar entradas do banco
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAppAccentColor,
        onPressed: () async {
          if(arguments?.id != null) {
            _deleteItem(arguments?.id as int, context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Deletado com sucesso!'),
            ));
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Não foi possível deletar!'),
            ));
          }
        },
        child: const Icon(Icons.delete),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image(
                    image: NetworkImage(ImageHelper.checkUrlForImage(arguments?.urlFoto)),
                  ),
                ),
                const SizedBox(height: 10),
                const CustomListTitle(
                  text: 'Materiais:',
                ),
                Container(
                  child:
                      Text(arguments?.materiais ?? 'Materiais indisponíveis'),
                ),
                const SizedBox(height: 20),
                const CustomListTitle(
                  text: 'Passo a Passo:',
                ),
                Container(
                  child:
                      Text(arguments?.passos ?? 'Passo a passo indisponível'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
