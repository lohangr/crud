import 'package:crud/model/tarefas.dart';
import 'package:flutter/material.dart';

class TarefasProvider with ChangeNotifier {
  List<Tarefas> _tarefas = [];

  List<Tarefas> get tarefas => _tarefas;

  void adicionarTarefa(Tarefas novaTarefa) {
    _tarefas.add(novaTarefa);
    notifyListeners();
  }

  void excluirTarefa(Tarefas tarefas) {
    _tarefas.remove(tarefas);
    notifyListeners();
  }

  void atualizarTarefa(Tarefas tarefaAtualizada) {
    final index =
        _tarefas.indexWhere((element) => element.nome == tarefaAtualizada.nome);
    if (index != -1) {
      _tarefas[index] = tarefaAtualizada;
      notifyListeners();
    }
  }

  void atualizarListaTarefas(List<Tarefas> novasTarefas) {
    _tarefas.clear();
    _tarefas.addAll(novasTarefas);
    notifyListeners();
  }
}
