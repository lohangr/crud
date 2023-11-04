import 'package:crud/model/tarefas.dart';
import 'package:crud/pages/formulario_tarefas.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crud/provider/tarefas_provider.dart';
import 'package:provider/provider.dart';
import 'package:crud/pages/page_inicial.dart';

class TarefasDetalhesPage extends StatefulWidget {
  Tarefas tarefas;

  TarefasDetalhesPage({Key? key, required this.tarefas}) : super(key: key);

  @override
  State<TarefasDetalhesPage> createState() => _TarefasDetalhesPageState();
}

class _TarefasDetalhesPageState extends State<TarefasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');
  bool isUrl = false;

  @override
  void initState() {
    super.initState();
  }

  void editarTarefa(BuildContext context, Tarefas tarefas) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioTarefas(tarefas: tarefas),
      ),
    );

    if (resultado != null) {
      // Atualize a tarefa existente com as informações editadas
      tarefas.nome = resultado.nome;
      tarefas.descricao = resultado.descricao;
      Provider.of<TarefasProvider>(context, listen: false)
          .atualizarTarefa(resultado);
      Navigator.pop(context, resultado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefas.nome),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navegue para a página de edição e passe a tarefa atual como argumento
              editarTarefa(context, widget.tarefas);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // Ajuste o espaçamento conforme necessário
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
                16.0), // Ajuste o espaçamento conforme necessário
            child: Text(
              widget.tarefas.descricao,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
