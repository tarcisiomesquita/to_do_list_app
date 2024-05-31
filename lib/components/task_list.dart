import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    final index =
        TasksManager.instance.tasks.indexWhere((task) => task.id == id);

    TasksManager.instance.tasks.removeAt(index);
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 6,
                    ),
                    child: GestureDetector(
                      onTap: () => onEdit(task),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 1 / 5,
                          children: [
                            SlidableAction(
                              onPressed: (_) => _deleteTask(task.id),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              icon: Icons.delete,
                              label: 'Deletar',
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: ListTile(
                            title: Text(task.title,
                                style: Theme.of(context).textTheme.titleMedium),
                            subtitle: Text(task.description),
                            trailing: Checkbox(
                                value: task.isChecked,
                                onChanged: (bool? value) {
                                  _checkBoxSwitch(task.id, value!);
                                }),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
