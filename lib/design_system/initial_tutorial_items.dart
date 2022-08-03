//Itens de tutorial a serem adicionados inicialmente ao projeto

import 'package:need_help/models/tutorial_item.dart';

///TutorialItem de como fazer uma lasagna
TutorialItem kLasagnaTutorialItem = const TutorialItem(
  nome: 'Lasagna',
  materiais: 'Queijo, presunto, etc.',
  passos: 'Compre a lasagna pronta no mercado.',
  urlFoto: 'https://www.jessicagavin.com/wp-content/uploads/2017/07/meat-lasagna-1200.jpg',
  categoria: 'Comidas',
);

///TutorialItem de como amarrar um sapato
TutorialItem kAmarrarSapatoTutorialItem = const TutorialItem(
  nome: 'Amarrar sapatos',
  materiais: 'Um par de sapatos (e pés)',
  passos: 'Pegue o cadarço...',
  urlFoto: null,
  categoria: 'Vestuário',
);

///TutorialItem de como abrir os olhos ô.ô
TutorialItem kAbrirOlhosTutorialItem = const TutorialItem(
  nome: 'Abrir os olhos',
  materiais: 'Olhos (de preferências os seus)',
  passos: 'Parabéns! Se você está lendo isso, já conseguiu!',
  urlFoto: null,
  categoria: 'Bizarrices',
);
