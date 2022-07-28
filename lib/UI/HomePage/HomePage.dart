import 'package:flutter/material.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
import 'package:todo_task/Core/Utils/Blocs/AddTask/add_task_cubit.dart';
import 'package:todo_task/Core/Utils/Notification/NotificationApi.dart';
import 'package:todo_task/UI/HomePage/Favorite/Favorite.dart';
import 'package:todo_task/UI/HomePage/UnCompletedPage/UnCompletedPage.dart';
import 'package:todo_task/UI/Schedule/SchedulePage.dart';
import 'AllPage/AllPage.dart';
import 'AllPage/Widgets/AppBarIcon.dart';
import 'CompletedPage/CompletedPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Board",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          AppBarIcon(
              icon: Icons.calendar_month_outlined,
              onClick: () {
                AddTaskCubit.get(context).selectedDate =
                    DateTime.now().toString().split(" ")[0];
                AddTaskCubit.get(context).onSelectDate();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SchedulePage()));
              }),
          AppBarIcon(
              icon: Icons.menu,
              onClick: () {
                NotificationApi.showNotification(
                    id: 1,
                    body: "الله عليك يا عم يحيى",
                    title: "النوتفكيشن الاعظم على الاطلاق",
                    payload: "Yehiaaa.com");
              }),
        ],
      ),
      body: TitleScrollNavigation(
        barStyle: const TitleNavigationBarStyle(
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
          spaceBetween: 25,
        ),
        titles: const [
          "All",
          "Completed",
          "Uncompleted",
          "Favorite",
        ],
        pages: const [
          AllPage(),
          CompletedPage(),
          UnCompletedPage(),
          Favorite(),
        ],
      ),
    );
  }
}
