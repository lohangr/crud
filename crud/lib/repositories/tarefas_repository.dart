import 'package:crud/model/tarefas.dart';

class TarefasRepository {
  static List<Tarefas> tabela = [
    Tarefas(
      nome: 'Tarefa 1',
      descricao: 'fazer trabalho de Flutter',
    ),
    Tarefas(
      nome: 'Tarefa 2',
      descricao: 'Continuar trabalho',
    ),
    Tarefas(
      nome: 'Tarefa 3',
      descricao: 'Revisar trabalho',
    ),
    Tarefas(
      nome: 'Tarefa final',
      descricao: 'Terminar trabalho',
    ),
  ];
}
