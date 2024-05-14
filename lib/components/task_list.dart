import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list_app/models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList(
      {required this.tasks,
      required this.onCheck,
      required this.onEdit,
      required this.onDelete,
      super.key});

  final List<Task> tasks;
  final void Function(String id, bool isChecked) onCheck;
  final void Function(Task task) onEdit;
  final void Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    tasks.sort((a, b) {
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
    tasks.sort((a, b) {
      return a.isChecked.toString().compareTo(b.isChecked.toString());
    });
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          final task = tasks[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 5,
            ),
            child: GestureDetector(
              onTap: () => onEdit(task),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 1 / 5,
                  children: [
                    SlidableAction(
                        onPressed: (_) => onDelete(task.id),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete),
                  ],
                ),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    trailing: Checkbox(
                        value: task.isChecked,
                        onChanged: (bool? value) {
                          onCheck(task.id, value!);
                        }),
                    title: Text(task.title),
                    subtitle: Text(task.description),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
