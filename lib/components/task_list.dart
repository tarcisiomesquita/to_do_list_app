import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList(
      {required this.tasks,
      required this.onCheck,
      required this.onEdit,
      super.key});

  final List<Task> tasks;
  final void Function(String id, bool isChecked) onCheck;
  final void Function(Task task) onEdit;

  @override
  Widget build(BuildContext context) {
    tasks.sort((a, b) {
      return a.title.toLowerCase().compareTo(b.title.toLowerCase());
    });
    tasks.sort((a, b) {
      return a.isChecked.toString().compareTo(b.isChecked.toString());
    });
    return SizedBox(
        height: 300,
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
              );
            }));
  }
}
