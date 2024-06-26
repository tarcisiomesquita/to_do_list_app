import 'package:to_do_list_app/models/task.dart';
import 'package:uuid/uuid.dart';

final dummyTasks = [
  Task(
    id: const Uuid().v4(),
    title: 'quarta',
    description: 'quarta',
    isChecked: false,
    date: DateTime(2024, 6, 5),
  ),
  Task(
    id: const Uuid().v4(),
    title: 'terça',
    description: 'terça',
    isChecked: false,
    date: DateTime(2024, 6, 4),
  ),
  Task(
    id: const Uuid().v4(),
    title: 'quarta2',
    description: 'quarta2',
    isChecked: false,
    date: DateTime(2024, 6, 5),
  ),
  Task(
      id: const Uuid().v4(),
      title: 'quinta',
      description: 'quinta',
      isChecked: false,
      date: DateTime(2024, 6, 6)),
  Task(
    id: const Uuid().v4(),
    title: 'domingo',
    description: 'domingo',
    isChecked: false,
    date: DateTime(2024, 6, 2),
  ),
  Task(
    id: const Uuid().v4(),
    title: 'domingo2',
    description: 'domingo2',
    isChecked: false,
    date: DateTime(2024, 6, 2),
  ),
  Task(
    id: const Uuid().v4(),
    title: 'terça3',
    description: 'terça3',
    isChecked: false,
    date: DateTime(2024, 6, 4),
  ),
  Task(
    id: const Uuid().v4(),
    title: 'terça2',
    description: 'terça2',
    isChecked: false,
    date: DateTime(2024, 6, 4),
  ),
];
