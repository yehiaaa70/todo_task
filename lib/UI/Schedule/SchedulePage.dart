import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';
import 'package:todo_task/Core/Utils/Function/MyToast.dart';
import 'package:todo_task/UI/HomePage/HomePage.dart';
import 'package:todo_task/UI/Schedule/Widgets/MyTimeLinePicker.dart';

import 'Widgets/ScheduleListTask.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({Key? key, this.itemUpdate}) : super(key: key);

  Map? itemUpdate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 18,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              elevation: 1,
              backgroundColor: Colors.white,
              title: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Schedule",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Column(
              children:  [
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                 child: MyTimeLinePicker(taskCubit: AddTaskCubit.get(context)),
               ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
                  child: Container(height: 1,width: double.infinity,color: Colors.grey,),
                ),
                Expanded(child: ScheduleListTask(date:AddTaskCubit.get(context).selectedDate,))
              ],
            ),
          );
        });
  }
}
