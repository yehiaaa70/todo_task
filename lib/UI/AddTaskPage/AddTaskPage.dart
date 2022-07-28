import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';
import 'package:todo_task/Core/Utils/Function/MyToast.dart';
import 'package:todo_task/Core/Utils/Widgets/MyButton.dart';
import 'package:todo_task/UI/AddTaskPage/Widgets/ColorPicker.dart';
import 'package:todo_task/UI/AddTaskPage/Widgets/MyDropdownButton.dart';
import 'package:todo_task/UI/AddTaskPage/Widgets/TimeDatePicker.dart';
import 'package:todo_task/UI/HomePage/HomePage.dart';

import '../../Core/Utils/Widgets/ShowLoadingIndicator.dart';
import 'Widgets/MyTextFormField.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key, this.itemUpdate}) : super(key: key);

  Map? itemUpdate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          if (state is TaskAddedSuccessfully) {
            if (itemUpdate == null) {
              MyToast.myToastShow(
                  text: "Added Successfully", color: Colors.green);
            } else {
              MyToast.myToastShow(
                  text: "Updated Successfully", color: Colors.green);
            }
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.of(context).pop(
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
              AddTaskCubit.get(context).getAllTasks();
            });
          } else if (state is TaskAddedFailure) {
            if (itemUpdate == null) {
              MyToast.myToastShow(text: "Added Failure", color: Colors.red);
            } else {
              MyToast.myToastShow(text: "Update Failure", color: Colors.red);
            }
          }

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
                  "Add task",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MyTextFormField(
                            inputType: TextInputType.text,
                            title: "Title",
                            hint: "Title",
                            controller:
                                AddTaskCubit.get(context).titleController,
                          ),
                          MyTextFormField(
                            inputType: TextInputType.text,
                            title: "Deadline",
                            hint: "Choose The Date  --->",
                            icon: Icons.calendar_month,
                            calenderOnClick: () {
                              Picker.showDatePicker(context,
                                  AddTaskCubit.get(context).deadlineController);
                            },
                            controller:
                                AddTaskCubit.get(context).deadlineController,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MyTextFormField(
                                  inputType: TextInputType.text,
                                  title: "Start Time",
                                  hint: "Choose The Time  --->",
                                  icon: Icons.access_time_outlined,
                                  calenderOnClick: () {
                                    Picker.showTimePicker(
                                        context,
                                        AddTaskCubit.get(context)
                                            .startTimeController);
                                  },
                                  controller: AddTaskCubit.get(context)
                                      .startTimeController,
                                ),
                              ),
                              Expanded(
                                child: MyTextFormField(
                                  inputType: TextInputType.text,
                                  title: "End Time",
                                  hint: "Choose The Time  --->",
                                  icon: Icons.access_time_outlined,
                                  calenderOnClick: () {
                                    Picker.showTimePicker(
                                        context,
                                        AddTaskCubit.get(context)
                                            .endTimeController);
                                  },
                                  controller: AddTaskCubit.get(context)
                                      .endTimeController,
                                ),
                              ),
                            ],
                          ),
                          MyDropdownButton(title: "Remind"),
                          MyDropdownButton(title: "Repeat"),
                          const SizedBox(height:25 ,),
                          MyColorPicker(addTaskCubit: AddTaskCubit.get(context),mainContext: context,)
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                  child: MyButton(
                      text: itemUpdate == null
                          ? "Create a Task"
                          : "Update This Task",
                      onClick: () {
                        AddTaskCubit task = AddTaskCubit.get(context);
                        if (task.titleController.text.isEmpty ||
                            task.deadlineController.text.isEmpty ||
                            task.startTimeController.text.isEmpty ||
                            task.endTimeController.text.isEmpty) {
                          MyToast.myToastShow(
                              text: "Please Complete The Data",
                              color: Colors.red);
                        } else {
                          if (itemUpdate == null) {
                            task.addNewTask();
                          } else {
                            task.taskUpdate(itemUpdate!['id']);
                          }
                        }
                      }),
                )
              ],
            ),
          );
        });
  }
}
