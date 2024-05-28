import 'package:flutter/material.dart';
import 'package:to_do_list_app/utils/format.intl.dart';
import 'package:to_do_list_app/utils/task_manager.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => TaskFormState();
}

class TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isEmpty || description.isEmpty) {
      return;
    }

    TasksManager.instance.addTask(title, description, _selectedDate);
    Navigator.pop(context);
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
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Data: ${formatDate(_selectedDate)}'),
                const Spacer(),
                TextButton(
                    onPressed: _showDatePicker,
                    child: const Text('Selecionar Data'))
              ],
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
