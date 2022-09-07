import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:need_help/design_system/colors.dart';
import 'package:need_help/design_system/strings.dart';
import 'package:need_help/design_system/widgets/category_button.dart';
import 'package:need_help/design_system/widgets/circular_tutorial_button.dart';
import 'package:need_help/helpers/image_helper.dart';
import 'package:need_help/helpers/tutorial_item_persistence_helper.dart';
import 'package:need_help/models/tutorial_item.dart';
import 'package:need_help/screens/info_screen.dart';
import 'package:need_help/screens/tutorial_screen.dart';
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
  ///Itens completos do banco a serem mostrados na tela
  List<TutorialItem> _tutorialItems = [];

  ///Categorias para filtro aparecendo no topo da tela
  List<String> _categories = [];

  var _filteredBy = '';

  //Booleano para denotar carregamento da aplicação
  //Atualmente, não utilizado, mas pode ser implementado no futuro
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

  ///Método para recuperar os itens  de uma categoria específica
  ///do banco e mostrar apenas eles na tela
  void _filterItems(String category) async {
    if (kDebugMode) {
      print('Filtering items');
    }

    //Prevenção de categorias nulas
    if (category == _filteredBy) {
      _refreshItems();
      _filteredBy = '';
      return;
    }

    _tutorialItems = [];

    var data = await DatabaseHelper.getByCategory(category);

    if (data.isEmpty) {
      _refreshItems();
    } else {
      setState(() {
        _tutorialItems = data;

        _filteredBy = category;

        if (kDebugMode) {
          print(_tutorialItems);
        }
      });
    }
  }

  ///Função para deletar todos os itens e recriá-los.
  ///Esta função é puramente para teste da aplicação e
  ///se encontra "escondida" na aplicação.
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
        title: InkWell(
          onDoubleTap: () {
            //Easter Egg para reset de configurações (para testes)
            _deleteAllItems();
            _refreshItems();
          },
          child: Text(
            kAppName,
            style: TextStyle(
              color: kTitleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
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
                    if (_categories.isNotEmpty) {
                      final category = _categories[index];
                      return GridTile(
                          child: CategoryButton(
                        text: category,
                        onPressed: () {
                          _filterItems(category);
                        },
                      ));
                    } else {
                      //Contingência para problema do GridView.builder com listas vazias
                      return Container();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: GridView.builder(
                    //scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _tutorialItems.length,
                    itemBuilder: (context, index) {
                      if (_tutorialItems.isNotEmpty) {
                        final item = _tutorialItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              CircularTutorialButton(
                                  innerWidget:
                                      ImageHelper.circleAvatarBasedOnImage(
                                          item),
                                  onPressed: () async {
                                    //Chamada da tela de tutorial
                                    TutorialItem chosenItem;
                                    chosenItem =
                                        await TutorialItemPersistenceHelper
                                            .getTutorialItem(item.id as int);

                                    await Navigator.pushNamed(
                                      context,
                                      TutorialScreen.id,
                                      arguments: TutorialScreenArguments(
                                        id: chosenItem.id,
                                        nome: chosenItem.nome,
                                        materiais: chosenItem.materiais,
                                        passos: chosenItem.passos,
                                        urlFoto: chosenItem.urlFoto ?? '',
                                        categoria: chosenItem.categoria ?? '',
                                      ),
                                    );

                                    _refreshItems();
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
                      } else {
                        //Contingência para problema do GridView.builder com listas vazias
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
            Material(
              color: kAppAccentColor,
              borderRadius: BorderRadius.circular(0),
              elevation: 2,
              child: ListTile(
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    InfoScreen.id,
                  );

                  _refreshItems();
                },
                title: Text(
                  'Adicionar novo procedimento',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kAppTextColor,
                    fontWeight: FontWeight.bold,
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
