import 'package:crud/model/tarefas.dart';
import 'package:crud/pages/formulario_tarefas.dart';
import 'package:crud/pages/tarefas_detalhes_page.dart';
import 'package:crud/provider/tarefas_provider.dart';
import 'package:crud/repositories/tarefas_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({Key? key}) : super(key: key);

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');
  // Armazena tarefas selecionadas
  List<Tarefas> selecionadas = [];
  // Armazena todas tarefas
  List<Tarefas> todasTarefas = [];

  void atualizarListaTarefas() {
    setState(() {
      final tarefasProvider = context.read<TarefasProvider>();
      final tarefasNovas = tarefasProvider.tarefas;
      final tabela = TarefasRepository.tabela;
      // Limpa lista de todas tarefas
      todasTarefas.clear();
      // Adicionas todas tarefas na lista
      todasTarefas.addAll([...tabela, ...tarefasNovas]);
    });
  }

  void mostrarDetalhes(Tarefas tarefas) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        // Navega para a pagina de detalhes da tarefa
        builder: (_) => TarefasDetalhesPage(tarefas: tarefas),
      ),
    );

    if (resultado != null) {
      // Atualize a lista de tarefas com o resultado da edicao
      final tarefasProvider =
          Provider.of<TarefasProvider>(context, listen: false);
      tarefasProvider.atualizarTarefa(resultado);
      atualizarListaTarefas(); // Atualize a lista
    }
  }

  // Navega para o formulario de tarefas
  navegarParaFormulario(BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FormularioTarefas()),
    );

    // Verifica se o resultado nao e nulo e realiza as acoes
    if (resultado != null) {
      final tarefasProvider =
          Provider.of<TarefasProvider>(context, listen: false);
      tarefasProvider.adicionarTarefa(resultado);
      atualizarListaTarefas(); // Atualize a lista
    }
  }

  // Exibe uma AppBar com os itens selecionados
  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text("Lista de Tarefas"),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        // Mostra a contagem de itens selecionados
        title: Text('${selecionadas.length} selecionados'),
        backgroundColor: const Color.fromARGB(255, 233, 215, 189),
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              excluirTarefasSelecionados();
            },
          ),
        ],
      );
    }
  }

  void excluirTarefasSelecionados() {
    final tarefasProvider =
        Provider.of<TarefasProvider>(context, listen: false);
    for (var tarefas in selecionadas) {
      if (TarefasRepository.tabela.contains(tarefas)) {
        TarefasRepository.tabela.remove(tarefas);
      } else {
        tarefasProvider.excluirTarefa(tarefas);
      }
    }
    // Reseta o estado das tarefas selecionadas
    setState(() {
      selecionadas.clear();
    });
  }

  late Tarefas tarefas;
  bool isUrl = false;

  @override
  void initState() {
    super.initState();
    // Chama o metodo pra atualizar a lista de tarefas
    atualizarListaTarefas();
  }

  @override
  Widget build(BuildContext context) {
    final tarefasProvider = context.read<TarefasProvider>();
    final tarefasNovas = tarefasProvider.tarefas;
    final tabela = TarefasRepository.tabela;
    todasTarefas = [...tabela, ...tarefasNovas];

    // Retorna um Scaffold com AppBar e uma lista de tarefas
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        // Constroi os itens da lista
        itemBuilder: (BuildContext context, int index) {
          final tarefas = todasTarefas[index];
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            title: Text(
              tarefas.nome,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Verifica se a tarefa esta selecionada com base na lista 'selecionadas'
            selected: selecionadas.contains(tarefas),
            selectedTileColor: const Color.fromARGB(255, 246, 239, 232),
            // Lida com a acao de pressionar longamente um ListTile
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tarefas))
                    ? selecionadas.remove(tarefas)
                    : selecionadas.add(tarefas);
              });
            },
            onTap: () {
              if (selecionadas.isEmpty) {
                mostrarDetalhes(tarefas);
              } else {
                setState(() {
                  if (selecionadas.contains(tarefas)) {
                    selecionadas.remove(tarefas);
                  } else {
                    selecionadas.add(tarefas);
                  }
                });
              }
            },
          );
        },
        padding: EdgeInsets.all(16),
        // Separador que sera exibido entre os itens da lista
        separatorBuilder: (_, __) => Divider(),
        itemCount: todasTarefas.length,
      ),
      // Botao flutuante na tela, que adiciona uma nova tarefa
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navegarParaFormulario(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
