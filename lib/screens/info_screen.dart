import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';
import 'package:need_help/design_system/widgets/editable_text_field.dart';
import 'package:need_help/design_system/widgets/custom_list_title.dart';
import 'package:need_help/design_system/widgets/save_rounded_button.dart';

import '../helpers/tutorial_item_persistence_helper.dart';

///Telas de tutoriais com informações vindas do banco
class InfoScreen extends StatelessWidget {
  static const id = 'info_screen';

  final tituloController = TextEditingController();
  final materiaisController = TextEditingController();
  final passosController = TextEditingController();
  final urlController = TextEditingController();
  final categoriaController = TextEditingController();

  ///Construtor
  InfoScreen({
    Key? key,
  }) : super(key: key);

  ///Método para inserir um item novo no banco
  Future<void> _addItem(
    String nome,
    String materiais,
    String passos,
    String? urlFoto,
    String? categoria,
    context,
  ) async {
    try {
      TutorialItemPersistenceHelper.addItem(
          nome, materiais, passos, urlFoto, categoria);
      Navigator.pop(context);
    } catch (ex) {
      if (kDebugMode) {
        print('Exception: $ex');
      }

      throw Exception(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppThemeColor,
        title: const Text(
          'Novo procedimento',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomListTitle(
                    text: 'Preencha os campos para criar seu tutorial!'),
                const SizedBox(height: 10),
                //Nome
                EditableTextField(
                  tutorialLabelText: 'Título',
                  tutorialHelperText: '"Como fazer miojo"',
                  textController: tituloController,
                ),
                const SizedBox(height: 10),
                //Materiais
                EditableTextField(
                  tutorialLabelText: 'Materiais',
                  tutorialHelperText: '"3 metros de corda, uma pá..."',
                  textController: materiaisController,
                ),
                const SizedBox(height: 10),
                //Passos
                EditableTextField(
                  tutorialLabelText: 'Passos',
                  tutorialHelperText:
                      '"Primeiro, pule bem alto. Em seguida, tente não cair..."',
                  textController: passosController,
                ),
                const SizedBox(height: 10),
                //URL da foto
                EditableTextField(
                  tutorialLabelText: 'URL para fotos (não obrigatório)',
                  tutorialHelperText:
                      '"https://i.kym-cdn.com/entries/icons/mobile/000/022/134/elmo.jpg"',
                  textController: urlController,
                ),
                const SizedBox(height: 10),
                //Categoria
                EditableTextField(
                  tutorialLabelText: 'Categoria (não obrigatório)',
                  tutorialHelperText: '"Comidas"',
                  textController: categoriaController,
                ),
                const SizedBox(height: 24),
                SaveRoundedButton(
                  text: 'Salvar',
                  onPressed: () async {
                    try {
                      _addItem(
                          tituloController.text,
                          materiaisController.text,
                          passosController.text,
                          urlController.text,
                          categoriaController.text,
                          context);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Salvo com sucesso!'),
                      ));
                    }
                    catch (Exception) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Houve um erro salvar o procedimento!'),
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
