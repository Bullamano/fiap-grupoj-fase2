import 'package:flutter/material.dart';
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

  //Funçãoo para denotar carregamento da aplicação
  //bool _isLoading = true;

  ///Método para recuperar os itens do banco
  void _refreshItems() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      _tutorialItems = data;
      //_isLoading = false;
    });
  }

  //TODO separar a lógica de banco em uma classe própria

  ///Método para inserir um item novo no banco
  Future<void> _addItem(
    String nome,
    String materiais,
    String passos,
    String? urlFoto,
    String? categoria,
  ) async {
    TutorialItem tutorialItem = new TutorialItem(
        nome: nome,
        materiais: materiais,
        passos: passos,
        urlFoto: urlFoto,
        categoria: categoria);
    await DatabaseHelper.createItem(tutorialItem);

    print('Insert: done');

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
    TutorialItem tutorialItem = new TutorialItem(
        nome: nome,
        materiais: materiais,
        passos: passos,
        urlFoto: urlFoto,
        categoria: categoria);
    await DatabaseHelper.updateItem(tutorialItem);
    _refreshItems();
  }

  ///Método para deletar uma entrada do banco
  void _deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted!'),
    ));
    _refreshItems();
  }

  ///Estado inicial.
  ///Busca os itens do banco para popular a tela
  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  //TODO reformular a tela (a atual é apenas uma prova de conceito para o banco)
  ///Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Menu inicial',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                //TODO Allan: colocar os itens iniciais do banco
                _addItem('Lasagna',
                    'Queijo, presunto, etc.',
                    'Compre a lasagna pronta no mercado.',
                    'https://www.jessicagavin.com/wp-content/uploads/2017/07/meat-lasagna-1200.jpg',
                     'Comidas');
                //print('Clicado');
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Adicionar entrada no banco',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                print(_tutorialItems[0].toString());
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Printar entrada no console',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () {
                print(_tutorialItems.toString());
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Printar banco completo',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
