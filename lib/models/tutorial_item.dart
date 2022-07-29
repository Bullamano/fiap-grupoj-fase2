///Classe de modelo para itens do banco de dados (tutoriais)
class TutorialItem {
  final int? id;
  final String nome;
  final String materiais;
  final String passos;
  final String? urlFoto;
  final String? categoria;

  ///Construtor
  ///ID não é required pois
  ///é gerado automaticamente pelo DB
  const TutorialItem({
    this.id,
    required this.nome,
    required this.materiais,
    required this.passos,
    required this.urlFoto,
    required this.categoria,
  });

  ///Mapeamento para objeto
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'nome': nome,
      'materiais': materiais,
      'passos': passos,
      'urlFoto': urlFoto,
      'categoria': categoria,
    };
  }

  ///toString para facilitar prints
  @override
  String toString(){
    return 'TutorialItem{id: $id, nome: $nome, categoria: $categoria}';
  }
}