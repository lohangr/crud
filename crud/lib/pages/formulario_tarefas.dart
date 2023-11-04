import 'package:flutter/material.dart';
import 'package:crud/model/tarefas.dart';
import 'package:crud/provider/tarefas_provider.dart';
import 'package:provider/provider.dart';

// Formulario de tarefas
class FormularioTarefas extends StatefulWidget {
  final Tarefas? tarefas;

  const FormularioTarefas({this.tarefas});

  @override
  State<FormularioTarefas> createState() => _FormularioTarefasState();
}

// Estado associado ao FormularioTarefas
class _FormularioTarefasState extends State<FormularioTarefas> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.tarefas != null) {
      // Preencha os campos do formulario com os detalhes da tarefa para edicao
      _nomeController.text = widget.tarefas!.nome;
      _descricaoController.text = widget.tarefas!.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.tarefas != null ? 'Editar Tarefa' : 'Adicionar Tarefa'),
      ),
      body: Form(
        key: _formKey, // Chave valida formulario
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome da Tarefa'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira o nome da tarefa.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição da Tarefa'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira a descrição da tarefa.';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final novaTarefa = Tarefas(
                    nome: _nomeController.text,
                    descricao: _descricaoController.text,
                  );

                  // Retorne a nova tarefa como resultado
                  Navigator.of(context).pop(novaTarefa);
                }
              },
              child: Text(widget.tarefas != null ? 'Salvar' : 'Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

// Verifica se a URL e valida
  bool isValidUrl(String url) {
    final regex = RegExp(r'^http(s)?://.+\..+');
    return regex.hasMatch(url);
  }
}
