import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list_app/components/task_list.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _tasks = [
    Task(
      id: const Uuid().v4(),
      title: 'Limpar caixa de areia dos gatos',
      description:
          'Retirar e colocar em um saco de lixo a areia da caixa e repor',
      isChecked: false,
    ),
    Task(
      id: const Uuid().v4(),
      title: 'Arrumar cozinha',
      description:
          'Enxugar e guardas louças na escorredeira e lavar louças restantes',
      isChecked: false,
    ),
  ];

  void _checkBoxSwitch(String id, bool value) {
    final index = _tasks.indexWhere((task) => task.id == id);
    setState(() {
      _tasks[index].isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarfeas'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TaskList(_tasks, _checkBoxSwitch),
            ],
          ),
        ));
  }
}
