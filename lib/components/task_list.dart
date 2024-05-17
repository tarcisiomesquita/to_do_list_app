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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
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
                    vertical: 6,
                    horizontal: 10,
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
                                onCheck(task.id, value!);
                              }),
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
