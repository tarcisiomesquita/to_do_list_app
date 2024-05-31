import 'package:flutter/material.dart';
import 'package:to_do_list_app/data/dummy_data.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:uuid/uuid.dart';

class TasksManager {
  static TasksManager instance = TasksManager();

  final List<Task> tasks = dummyTasks;

  DateTime currentDay = DateUtils.dateOnly(DateTime.now());

  List<Task> getSortedTaskList(DateTime currentDay) {
    return List<Task>.from(tasks)
      ..sort((a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      })
      ..sort((a, b) {
        return a.isChecked.toString().compareTo(b.isChecked.toString());
      })
      ..removeWhere((task) {
        return task.date != currentDay;
      });
  }

  void addTask(String title, String description, DateTime date) {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      isChecked: false,
      date: date,
    );

    tasks.add(newTask);
  }
}
