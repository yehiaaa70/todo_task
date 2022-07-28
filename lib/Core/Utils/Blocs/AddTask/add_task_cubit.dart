import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(context) => BlocProvider.of<AddTaskCubit>(context);

  late Database database;
  List<Map> tasks = [];
  List<Map> tasksComplete = [];
  List<Map> tasksUnComplete = [];
  List<Map> tasksFavorite = [];
  List<Map> tasksSelectedDate = [];
  ColorSwatch? mainColor = Colors.blue;
  ColorSwatch? tempMainColor;
  String pickColor = Colors.blue.toString().split("(")[2].split(")")[0];
  String selectedDate = '';
  DateTime? dateToDay ;

  TextEditingController titleController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

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
  String? remindValue;
  String? repeatValue;

  setColor() {
    mainColor = tempMainColor;
    pickColor = mainColor.toString().split("(")[2].split(")")[0];
    print(mainColor);
    print(mainColor.toString().split("(")[2].split(")")[0]);
    emit(TaskAddedLoading());
  }

  onSelectDate(){
    getAllTasks();
    emit(GetAllTasksSuccessful());
  }

  fillAllLists() {
    tasksComplete = tasks.where((item) => item['isCompleted'] == 1).toList();
    tasksUnComplete = tasks.where((item) => item['isCompleted'] == 0).toList();
    tasksFavorite = tasks.where((item) => item['isFavorite'] == 1).toList();
    if (selectedDate.isNotEmpty) {
      tasksSelectedDate =
          tasks.where((item) => item['deadline'] == selectedDate).toList();
    }
  }

  changeValue(String newValue, String title) {
    if (title == "Remind") {
      remindValue = newValue;
      emit(AddTaskUpdateValue());
    } else {
      repeatValue = newValue;
      emit(AddTaskUpdateValue());
    }
  }

  initDatabase() async {
    remindValue = itemsRemind.first;
    repeatValue = itemsRepeat.first;

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'todo.db');
    debugPrint('AppDatabaseInitialized');
    openAppDatabase(path: path);
    emit(AppDatabaseInitialized());
  }

  openAppDatabase({
    required String path,
  }) async {
    openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      debugPrint('Database Created');
      await db.execute('CREATE TABLE Tasks ('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,deadline TEXT,'
          'start_time TEXT,'
          'end_time TEXT,'
          'remind TEXT,'
          'repeat TEXT,'
          'isCompleted BOOLEAN,'
          'isFavorite BOOLEAN,'
          'color TEXT)');
    }, onOpen: (Database db) {
      debugPrint('AppDatabaseOpened');
      database = db;
      getAllTasks();
    });
  }

  addNewTask() async {
    // emit(TaskAddedLoading());
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Tasks(title,deadline,start_time,end_time,remind,repeat,isCompleted,isFavorite,color) VALUES("${titleController.text}","${deadlineController.text}","${startTimeController.text}","${endTimeController.text}","$remindValue","$repeatValue",${false},${false},"$pickColor")');
    }).then((value) {
      clearDataOfTextForm();
      emit(TaskAddedSuccessfully());
    }).onError((error, stackTrace) {
      emit(TaskAddedFailure());
    });
  }

  getAllTasks() {
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      debugPrint('Users Data Fetched');
      debugPrint(value.toString());
      tasks = value;
      fillAllLists();
      emit(GetAllTasksSuccessful());
    });
  }

  completedUpdate(String title, int newValue) {
    database.rawUpdate(
        'UPDATE Tasks SET isCompleted = ? WHERE title = "$title"',
        [(newValue)]).then((value) {
      getAllTasks();
      debugPrint('User Data Updated');
      emit(CompletedUpdatedSuccessful());
    });
  }

  favoriteUpdate(String title, int newValue) {
    database.rawUpdate('UPDATE Tasks SET isFavorite = ? WHERE title = "$title"',
        [(newValue)]).then((value) {
      getAllTasks();
      debugPrint('User Data Updated');
      emit(CompletedUpdatedSuccessful());
    });
  }

  taskUpdate(int id) {
    database.rawUpdate(
        'UPDATE Tasks SET title = ?, deadline = ?,start_time = ?,end_time = ?,remind = ?,repeat = ?,color = ? WHERE id = $id',
        [
          (titleController.text),
          (deadlineController.text),
          (startTimeController.text),
          (endTimeController.text),
          "$remindValue",
          "$repeatValue",
          pickColor
        ]).then((value) {
      clearDataOfTextForm();
      emit(TaskAddedSuccessfully());
    }).onError((error, stackTrace) {});
  }

  deleteSelectedTask({required Map item}) {
    database
        .rawDelete('DELETE FROM Tasks WHERE id = ${item['id']}')
        .then((value) {
      getAllTasks();
      debugPrint('Deleted User Successful');
      emit(TaskDeletedSuccessful());
    });
  }


  setDataToUpdate(Map item) {
    titleController.text = item['title'];
    deadlineController.text = item['deadline'];
    startTimeController.text = item['start_time'];
    endTimeController.text = item['end_time'];
    remindValue = item['remind'];
    repeatValue = item['repeat'];
    pickColor = item['color'];
    // mainColor = Color(int.parse("${item['color']}"));
  }

  clearDataOfTextForm() {
    titleController.clear();
    deadlineController.clear();
    startTimeController.clear();
    endTimeController.clear();
    remindValue = itemsRemind.first;
    repeatValue = itemsRepeat.first;
  }
}
