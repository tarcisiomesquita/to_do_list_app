import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:to_do_list_app/utils/format.intl.dart';
import 'package:to_do_list_app/utils/task_manager.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({this.task, super.key});

  final Task? task;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final bool isThereTask = widget.task != null;

  late final TextEditingController _titleController =
      TextEditingController(text: isThereTask ? widget.task!.title : '');
  late final TextEditingController _descriptionController =
      TextEditingController(text: isThereTask ? widget.task!.description : '');

  late DateTime _selectedDate =
      isThereTask ? widget.task!.date : DateUtils.dateOnly(DateTime.now());

  void _editTask(Task task) {
    final index =
        TasksManager.instance.tasks.indexWhere((e) => e.id == task.id);

    TasksManager.instance.tasks[index] = task;

    Navigator.pop(context);
  }

  void _submitForm() {
    if (isThereTask) {
      final editedTask = Task(
        id: widget.task!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        isChecked: widget.task!.isChecked,
        date: _selectedDate,
      );

      if (editedTask.title.isEmpty || editedTask.description.isEmpty) {
        return;
      }
      _editTask(editedTask);
    } else {
      final title = _titleController.text;
      final description = _descriptionController.text;
      if (title.isEmpty || description.isEmpty) {
        return;
      }

      TasksManager.instance.addTask(title, description, _selectedDate);

      Navigator.pop(context);
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
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
        padding: EdgeInsets.fromLTRB(
            10, 10, 10, 10 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const SizedBox(height: 10),
            Row(
              children: [
                Text('Data: ${formatDate(_selectedDate)}'),
                const Spacer(),
                TextButton(
                    onPressed: _showDatePicker,
                    child:
                        Text('${isThereTask ? 'Alterar' : 'Selecionar'} Data'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(isThereTask ? 'Salvar' : 'Nova Tarefa'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
