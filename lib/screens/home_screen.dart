import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';
import 'package:need_help/design_system/strings.dart';
import 'package:need_help/helpers/image_helper.dart';
import 'package:need_help/helpers/tutorial_item_persistence_helper.dart';
import 'package:need_help/models/tutorial_item.dart';
import '../helpers/database_helper.dart';

///StatefulWidget da tela Home
class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

///Classe regente da tela Home
class _HomeScreenState extends State<HomeScreen> {

  ///Itens completos do banco a serem mostrados
  ///na tela
  List<TutorialItem> _tutorialItems = [];

  //Função para denotar carregamento da aplicação
  //bool _isLoading = true;

  ///Método para recuperar os itens do banco (chamar sempre
  ///que houver uma mudança relacionada ao banco)
  void _refreshItems() async {
    if (kDebugMode) {
      print('Refreshing items');
    }

    var data = await DatabaseHelper.getItems();

    if (data.isEmpty) {
      TutorialItemPersistenceHelper.initialAddItem();
      data = await DatabaseHelper.getItems();
    }

    setState(() {
      _tutorialItems = data;
      //_isLoading = false;
    });

    if (kDebugMode) {
      _tutorialItems.forEach((item) {
        print(item);
      });
    }
  }

  ///Método para inserir um item novo no banco
  Future<void> _addItem(
    String nome,
    String materiais,
    String passos,
    String? urlFoto,
    String? categoria,
  ) async {
    TutorialItemPersistenceHelper.addItem(
        nome, materiais, passos, urlFoto, categoria);
    _refreshItems();
  }

  ///Método para atualizar uma entrada no banco
  Future<void> _updateItem(
    int id,
    String nome,
    String materiais,
    String passos,
    String? urlFoto,
    String? categoria,
  ) async {
    TutorialItemPersistenceHelper.updateItem(
        id, nome, materiais, passos, urlFoto, categoria);
    _refreshItems();
  }

  ///Método para deletar uma entrada do banco
  void _deleteItem(int id) async {
    TutorialItemPersistenceHelper.deleteItem(id);
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text('Successfully deleted!'),
    // ));
    _refreshItems();
  }

  //TODO retirar essa função
  //Esta função só existe pare testes
  void _deleteAllItems() async {
    if (kDebugMode) {
      print('Deleting all items');
    }

    List<TutorialItem> toDeleteItems = [];

    toDeleteItems = await DatabaseHelper.getItems();

    toDeleteItems.forEach((deleteItem) {
      TutorialItemPersistenceHelper.deleteItem(deleteItem.id as int);
    });

    _refreshItems();
  }

  ///Estado inicial.
  ///Busca os itens do banco para popular a tela
  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      print('Initializing Home Screen');
    }

    _refreshItems();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppThemeColor,
        title: Text(
          kAppName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      //O botão abaixo está aqui apenas para testes
      //TODO Retirar o botão abaixo ao final dos testes
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        backgroundColor: kAppAccentColor,
        onPressed: () {
          _deleteAllItems();
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: _tutorialItems.length,
          itemBuilder: (context, index) {
            final item = _tutorialItems[index];
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  ImageHelper.circleAvatarBasedOnImage(item),
                  const SizedBox(height: 5),
                  Text(
                    item.nome,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
