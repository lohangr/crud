class Tarefas {
  int id;
  String nome;
  String descricao;

  Tarefas({
    this.id =
        -1, // Valor padrão de -1 para indicar que o id ainda não foi definido.
    required this.nome,
    required this.descricao,
  });
}
