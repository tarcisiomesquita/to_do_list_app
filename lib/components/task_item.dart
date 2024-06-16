import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list_app/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final void Function(Task task) onEdit;
  final void Function(String id) onDelete;
  final void Function(String id, bool value) onCheckBoxClick;

  const TaskItem(
      {super.key,
      required this.task,
      required this.onEdit,
      required this.onDelete,
      required this.onCheckBoxClick});

  @override
  Widget build(BuildContext context) {
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
                onPressed: (_) => onDelete(task.id),
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
                  onCheckBoxClick(task.id, value!);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
