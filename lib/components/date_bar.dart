import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskListDay extends StatelessWidget {
  const TaskListDay(
      {super.key,
      required this.currentDay,
      required this.onBack,
      required this.onFoward});
  final DateTime currentDay;
  final void Function() onBack;
  final void Function() onFoward;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: const BoxDecoration(color: Colors.black87),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).colorScheme.background,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  DateFormat.EEEE().format(currentDay),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                )),
            IconButton(
              onPressed: onFoward,
              icon: const Icon(Icons.arrow_forward_ios),
              color: Theme.of(context).colorScheme.background,
            )
          ],
        ),
      );
    });
  }
}
