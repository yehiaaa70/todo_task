import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/Constants/Colors.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';

class MyDropdownButton extends StatelessWidget {
  MyDropdownButton({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  color: MyColors.txtFormColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: title == "Remind"
                      ? AddTaskCubit.get(context).remindValue
                      : AddTaskCubit.get(context).repeatValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black),
                  borderRadius: BorderRadius.circular(25),
                  dropdownColor: MyColors.txtFormColor,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    AddTaskCubit.get(context).changeValue(newValue!, title);
                  },
                  items: title == "Remind"
                      ? itemsRemind
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()
                      : itemsRepeat
                          .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final List<String> itemsRemind = [
    '10 minutes early',
    '30 minutes early',
    '1 hour early',
    '2 hour early',
    '3 hour early',
  ];
  final List<String> itemsRepeat = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
  ];
}
