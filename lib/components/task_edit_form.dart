import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:to_do_list_app/utils/format.intl.dart';
import 'package:to_do_list_app/utils/task_manager.dart';

class TaskEditForm extends StatefulWidget {
  const TaskEditForm(this.task, {super.key});

  final Task task;

  @override
  State<TaskEditForm> createState() => _TaskEditFormState();
}

class _TaskEditFormState extends State<TaskEditForm> {
  late final _titleController = TextEditingController(text: widget.task.title);
  late final _descriptionController =
      TextEditingController(text: widget.task.description);

  late DateTime _selectedDate = widget.task.date;

  void _editTask(Task task) {
    final index =
        TasksManager.instance.tasks.indexWhere((e) => e.id == task.id);

    TasksManager.instance.tasks[index] = task;

    Navigator.pop(context);
  }

  void _submitForm() {
    final editedTask = Task(
      id: widget.task.id,
      title: _titleController.text,
      description: _descriptionController.text,
      isChecked: widget.task.isChecked,
      date: _selectedDate,
    );

    if (editedTask.title.isEmpty || editedTask.description.isEmpty) {
      return;
    }
    _editTask(editedTask);
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 6)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Data: ${formatDate(widget.task.date)}'),
                const Spacer(),
                TextButton(
                    onPressed: _showDatePicker,
                    child: const Text('Alterar Data'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: _submitForm, child: const Text('Salvar'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
