class Task {
  String id;
  String title;
  String description;
  bool isChecked;
  final DateTime date;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.isChecked,
      required this.date});
}
