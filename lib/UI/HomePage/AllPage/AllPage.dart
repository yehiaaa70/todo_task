import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';
import 'package:todo_task/Core/Utils/Models/CheckBoxModel.dart';
import 'package:todo_task/UI/AddTaskPage/AddTaskPage.dart';

import '../../../Constants/Colors.dart';
import '../../../Core/Utils/Widgets/MyButton.dart';

class AllPage extends StatelessWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit,AddTaskState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state)  =>
     Column(
        children: [
          Expanded(
            flex: 2,
            child:RefreshIndicator(
              onRefresh: () async{
                AddTaskCubit.get(context).getAllTasks();
              },
              child: ListView.separated(
                  itemBuilder: (context, index) =>  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                    child:  CheckBoxModel(item: AddTaskCubit.get(context).tasks[index]),
                  ),
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  itemCount: AddTaskCubit.get(context).tasks.length),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 20),
            child: MyButton(text: "Add a task", onClick: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddTaskPage()));
            }),
          ),
        ],
      ),
    );
  }
}
