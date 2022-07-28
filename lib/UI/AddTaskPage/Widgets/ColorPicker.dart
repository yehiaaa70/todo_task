import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';

class MyColorPicker extends StatelessWidget {
  MyColorPicker(
      {Key? key, required this.addTaskCubit, required this.mainContext})
      : super(key: key);

  final AddTaskCubit addTaskCubit;
  final BuildContext mainContext;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: mainContext,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: Navigator.of(mainContext).pop,
              child: const Text('CANCEL'),
            ),
            TextButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                Navigator.of(mainContext).pop();
                addTaskCubit.setColor();
              },
            ),
          ],
        );
      },
    );
  }

  void _openFullMaterialColorPicker() async {
    _openDialog(
      "Full Material Color picker",
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: Color(int.parse(addTaskCubit.pickColor)),
        onMainColorChange: (color) => addTaskCubit.tempMainColor = color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        CircleAvatar(
          backgroundColor: Color(int.parse(addTaskCubit.pickColor)),
          radius: 35.0,
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: _openFullMaterialColorPicker,
          child: const Text('Show full material color picker'),
        ),
        const Spacer(),
      ],
    );
  }
}
