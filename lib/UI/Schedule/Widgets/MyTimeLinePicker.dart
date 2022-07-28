import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';

class MyTimeLinePicker extends StatelessWidget {
  const MyTimeLinePicker({Key? key, required this.taskCubit}) : super(key: key);

  final AddTaskCubit taskCubit;
  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.green,
      selectedTextColor: Colors.white,
      onDateChange: (date) {
        taskCubit.dateToDay=date;
        print(date.toString().split(" ")[0]);
        taskCubit.selectedDate=date.toString().split(" ")[0];
        taskCubit.onSelectDate();

      },
    );
  }
}
