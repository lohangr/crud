import 'package:crud/meu_aplicativo.dart';
import 'package:crud/provider/tarefas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TarefasProvider(),
      child: const MeuAplicativo(),
    ),
  );
}
