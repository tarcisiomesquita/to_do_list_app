import 'package:flutter/material.dart';
import 'package:to_do_list_app/styles/app_themes.dart';
import 'package:to_do_list_app/components/task_edit_form.dart';
import 'package:to_do_list_app/components/task_form.dart';
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
      theme: AppThemes().myTheme,
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
  final List<Task> _tasks = [];

  List<Task> _sortedTaskList() {
    return List<Task>.from(_tasks)
      ..sort((a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      })
      ..sort((a, b) {
        return a.isChecked.toString().compareTo(b.isChecked.toString());
      });
  }

  void _checkBoxSwitch(String id, bool value) {
    final index = _tasks.indexWhere((task) => task.id == id);
    setState(() {
      _tasks[index].isChecked = value;
    });
  }

  void _addTask(String title, String description) {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      isChecked: false,
    );
    setState(() {
      _tasks.add(newTask);
    });
    Navigator.pop(context);
  }

  void _editTask(Task task) {
    final index = _tasks.indexWhere((e) => e.id == task.id);

    setState(() {
      _tasks[index] = task;
    });
    Navigator.pop(context);
  }

  void _deleteTask(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _openTaskModal() {
    showModalBottomSheet(context: context, builder: (_) => TaskForm(_addTask));
  }

  void _openTaksEditModal(Task task) {
    showModalBottomSheet(
        context: context,
        builder: (_) => TaskEditForm(
              task,
              _editTask,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _openTaskModal, icon: const Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TaskList(
                tasks: _sortedTaskList(),
                onCheck: _checkBoxSwitch,
                onEdit: _openTaksEditModal,
                onDelete: _deleteTask,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: _openTaskModal,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
