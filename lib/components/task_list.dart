import 'package:flutter/material.dart';
import 'package:to_do_list_app/components/task_item.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:to_do_list_app/utils/task_manager.dart';

class TaskList extends StatelessWidget {
  const TaskList(
      {required this.tasks,
      required this.onCheck,
      required this.onEdit,
      required this.onDelete,
      super.key});

  final List<Task> tasks;

  final void Function(Task task) onEdit;
  final VoidCallback onDelete;
  final VoidCallback onCheck;

  void _deleteTask(String id) {
    TasksManager.instance.removeTask(id);
    onDelete();
  }

  void _checkBoxSwitch(String id, bool value) {
    final index =
        TasksManager.instance.tasks.indexWhere((task) => task.id == id);

    TasksManager.instance.tasks[index].isChecked = value;
    onCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: tasks.isEmpty
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma tarefa cadastrada',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Spacer()
                ],
              )
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (ctx, index) {
                  final task = tasks[index];
                  return TaskItem(
                    task: task,
                    onEdit: onEdit,
                    onDelete: _deleteTask,
                    onCheckBoxClick: _checkBoxSwitch,
                  );
                },
              ),
      ),
    );
  }
}
