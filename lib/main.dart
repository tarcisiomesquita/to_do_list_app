import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/components/date_bar.dart';
import 'package:to_do_list_app/data/dummy_data.dart';
import 'package:to_do_list_app/styles/app_themes.dart';
import 'package:to_do_list_app/components/task_edit_form.dart';
import 'package:to_do_list_app/components/task_form.dart';
import 'package:to_do_list_app/components/task_list.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:to_do_list_app/utils/methods.dart';
import 'package:uuid/uuid.dart';

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
  DateTime _currentDay = DateUtils.dateOnly(DateTime.now());

  void _checkBoxSwitch(String id, bool value) {
    final index =
        TasksManager.instance.tasks.indexWhere((task) => task.id == id);
    setState(() {
      TasksManager.instance.tasks[index].isChecked = value;
    });
  }

  void _openTaskModal() {
    showModalBottomSheet(context: context, builder: (_) => const TaskForm())
        .whenComplete(() {
      setState(() {});
    });
  }

  void _openTaksEditModal(Task task) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TaskEditForm(
        task,
      ),
    ).whenComplete(() {
      setState(() {});
    });
  }

  void _nextDay() {
    setState(() {
      // _currentDay = _currentDay.add(const Duration(days: 1));
      _currentDay = _currentDay.day + 1 >= DateTime.now().day + 7
          ? _currentDay.subtract(const Duration(days: 6))
          : _currentDay.add(const Duration(days: 1));
    });
  }

  void _lastDay() {
    setState(() {
      // _currentDay = _currentDay.subtract(const Duration(days: 1));
      _currentDay = _currentDay.day - 1 <= DateTime.now().day - 1
          ? _currentDay.add(const Duration(days: 6))
          : _currentDay.subtract(const Duration(days: 1));
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
              TaskListDay(
                currentDay: _currentDay,
                onBack: _lastDay,
                onFoward: _nextDay,
              ),
              TaskList(
                tasks: TasksManager.instance.sortedTaskList(_currentDay),
                onCheck: _checkBoxSwitch,
                onEdit: _openTaksEditModal,
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
