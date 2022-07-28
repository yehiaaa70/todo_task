import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';

import '../../../UI/AddTaskPage/AddTaskPage.dart';

class CheckBoxModel extends StatelessWidget {
  CheckBoxModel({Key? key, required this.item}) : super(key: key);

  final Map item;

  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    var items = [
      item['isFavorite'] == 0 ? "Favorite" : "UnFavorite",
      'Update',
      'Delete',
    ];

    int myColors = int.parse("${item['color']}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTileFormField(
              title: Text(
                item['title'],
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              activeColor: Color(myColors),
              borderColor: Color(myColors),
              checkColor: Colors.white70,
              initialValue: item['isCompleted'] == 1 ? true : false,
              dense: false,
              onChanged: (value) {
                AddTaskCubit.get(context)
                    .completedUpdate(item['title'], value == true ? 1 : 0);
              },
              autovalidateMode: AutovalidateMode.always,
              contentPadding: const EdgeInsets.all(1),
            ),
          ),
          DropdownButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            underline: Container(),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (value) {
              if (value == "Favorite" || value == "UnFavorite") {
                AddTaskCubit.get(context)
                    .favoriteUpdate(item['title'], value == "Favorite" ? 1 : 0);
              } else if (value == "Update") {
                AddTaskCubit.get(context).setDataToUpdate(item);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddTaskPage(itemUpdate: item,)));
              } else if (value == "Delete") {
                AddTaskCubit.get(context).deleteSelectedTask(item: item);
              }
            },
          ),
        ],
      ),
    );
  }
}
