class Tarefas {
  int id;
  String nome;
  String descricao;

  Tarefas({
    this.id =
        -1, // Valor padrao de -1 para indicar que o id ainda nao foi definido
    required this.nome,
    required this.descricao,
  });
}
