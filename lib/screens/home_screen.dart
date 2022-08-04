import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';
import 'package:need_help/design_system/strings.dart';
import 'package:need_help/design_system/widgets/category_button.dart';
import 'package:need_help/design_system/widgets/circular_tutorial_button.dart';
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

  List<String> _categories = [];

  //Função para denotar carregamento da aplicação
  //bool _isLoading = true;

  ///Método para recuperar os itens do banco (chamar sempre
  ///que houver uma mudança relacionada ao banco)
  void _refreshItems() async {
    if (kDebugMode) {
      print('Refreshing items');
    }

    _tutorialItems = [];
    _categories = [];

    var data = await DatabaseHelper.getItems();

    if (data.isEmpty) {
      TutorialItemPersistenceHelper.initialAddItem();
      data = await DatabaseHelper.getItems();
    }

    setState(() {
      _tutorialItems = data;

      //_isLoading = false;

      _tutorialItems.forEach((item) {
        if (kDebugMode) {
          print(item);
        }
        if (item.categoria!.isNotEmpty &&
            !(_categories.any((category) => item.categoria == category))) {
          _categories.add(item.categoria as String);
        }
      });

      if (kDebugMode) {
        print(_categories);
      }
    });
  }

  ///Método para inserir um item novo no banco
  Future<void> _addItem(String nome,
      String materiais,
      String passos,
      String? urlFoto,
      String? categoria,) async {
    TutorialItemPersistenceHelper.addItem(
        nome, materiais, passos, urlFoto, categoria);
    _refreshItems();
  }

  ///Método para atualizar uma entrada no banco
  Future<void> _updateItem(int id,
      String nome,
      String materiais,
      String passos,
      String? urlFoto,
      String? categoria,) async {
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
        backgroundColor: kAppAccentColor,
        onPressed: () {
          _deleteAllItems();
        },
        child: const Icon(Icons.delete),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                ),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 1 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    if(_categories.isNotEmpty){
                      final category = _categories[index];
                      return GridTile(
                          child: CategoryButton(
                            text: category,
                            onPressed: () {
                              //TODO Filtrar a lista por categoria
                            },
                          )
                      );
                    }
                    else{
                      //TODO Preencher melhor a tela quando a lista for vazia (contingência para problema do GridView.builder com listas vazias)
                      return Container();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _tutorialItems.length,
                    itemBuilder: (context, index) {
                      if(_tutorialItems.isNotEmpty){
                        final item = _tutorialItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              //ImageHelper.circleAvatarBasedOnImage(item),
                              CircularTutorialButton(innerWidget: ImageHelper
                                  .circleAvatarBasedOnImage(item),
                                  onPressed: (){
                                    //TODO chamar tela de cada tutorial daqui
                                  }),
                              const SizedBox(height: 5),
                              Text(
                                item.nome,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      else{
                        //TODO Preencher melhor a tela quando a lista for vazia (contingência para problema do GridView.builder com listas vazias)
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
