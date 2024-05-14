import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task.dart';

class TaskEditForm extends StatefulWidget {
  const TaskEditForm(this.task, this.onSubmit, {super.key});

  final Task task;
  final void Function(Task task) onSubmit;

  @override
  State<TaskEditForm> createState() => _TaskEditFormState();
}

class _TaskEditFormState extends State<TaskEditForm> {
  late final _titleController = TextEditingController(text: widget.task.title);
  late final _descriptionController =
      TextEditingController(text: widget.task.description);

  void _submitForm() {
    final editedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      isChecked: widget.task.isChecked,
    );

    if (editedTask.title.isEmpty || editedTask.description.isEmpty) {
      return;
    }
    widget.onSubmit(editedTask);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  onSubmitted: (_) => _submitForm(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: _submitForm,
                        child: const Text('Salvar alterações'))
                  ],
                )
              ],
            )));
  }
}