import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../Core/Utils/Blocs/AddTask/add_task_cubit.dart';
import 'ScheduleTaskItem.dart';

class ScheduleListTask extends StatelessWidget {
  const ScheduleListTask({Key? key, required this.date}) : super(key: key);

  final String date;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit,AddTaskState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:12 ),
            child: Row(
              children: [
                Text(
                  DateFormat('EEEE').format(AddTaskCubit.get(context).dateToDay??DateTime.now()),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:RefreshIndicator(
              onRefresh: () async{
                AddTaskCubit.get(context).getAllTasks();
              },
              child: ListView.separated(
                  itemBuilder: (context, index) =>  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                    child:  ScheduleTaskItem (item: AddTaskCubit.get(context).tasksSelectedDate[index]),
                  ),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  itemCount: AddTaskCubit.get(context).tasksSelectedDate.length),
            ),
          ),
        ],
      ),
    );
  }
}
