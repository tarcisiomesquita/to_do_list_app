import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/components/date_bar.dart';
import 'package:to_do_list_app/components/task_form.dart';
import 'package:to_do_list_app/styles/app_themes.dart';
import 'package:to_do_list_app/components/task_list.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:to_do_list_app/utils/task_manager.dart';

void main() {
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';
    initializeDateFormatting('pt_BR', null);

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
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
  void _openTaskModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) => const TaskForm()).whenComplete(() {
      setState(() {});
    });
  }

  void _openTaskEditModal(Task task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => TaskForm(
        task: task,
      ),
    ).whenComplete(() {
      setState(() {});
    });
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
        // minimum: const EdgeInsets.symmetric(vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateBar(
                currentDay: TasksManager.instance.currentDay,
                onDayChanged: () {
                  setState(() {});
                },
              ),
              TaskList(
                tasks: TasksManager.instance
                    .getSortedTaskList(TasksManager.instance.currentDay),
                onCheck: () {
                  setState(() {});
                },
                onEdit: _openTaskEditModal,
                onDelete: () {
                  setState(() {});
                },
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
