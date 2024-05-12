import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  const TaskForm(this.onSubmit, {super.key});

  final void Function(String title, String description) onSubmit;

  @override
  State<TaskForm> createState() => TaskFormState();
}

class TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submitForm() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isEmpty && description.isEmpty) {
      return;
    }
    widget.onSubmit(title, description);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Nova tarefa'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
