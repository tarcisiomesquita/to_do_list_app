import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/utils/task_manager.dart';

class DateBar extends StatelessWidget {
  const DateBar({
    super.key,
    required this.currentDay,
    required this.onDayChanged,
  });
  final DateTime currentDay;
  final VoidCallback onDayChanged;

  void _onNextDay() {
    TasksManager.instance.currentDay = currentDay.add(const Duration(days: 1));
    onDayChanged();
  }

  void _onLastDay() {
    TasksManager.instance.currentDay =
        currentDay.subtract(const Duration(days: 1));
    onDayChanged();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: const BoxDecoration(color: Colors.black87),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _onLastDay,
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).colorScheme.background,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  DateFormat('dd/MM/yyyy').format(currentDay),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                )),
            IconButton(
              onPressed: _onNextDay,
              icon: const Icon(Icons.arrow_forward_ios),
              color: Theme.of(context).colorScheme.background,
            )
          ],
        ),
      );
    });
  }
}
