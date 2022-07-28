part of 'add_task_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}
class AppDatabaseInitialized extends AddTaskState {}
class AddTaskUpdateValue extends AddTaskState {}
class TaskAddedLoading extends AddTaskState {}
class TaskAddedSuccessfully extends AddTaskState {}
class TaskAddedFailure extends AddTaskState {}


class GetAllTasksSuccessful extends AddTaskState {}
class CompletedUpdatedSuccessful extends AddTaskState {}
class TaskDeletedSuccessful extends AddTaskState {}



