import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:notification_tutorial/data/models/cached_todo_model.dart';
import 'package:notification_tutorial/data/models/notification_model.dart';
import 'package:notification_tutorial/data/repositories/notification_repository.dart';
import 'package:notification_tutorial/data/services/local_service/local_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository,
        super(
          NotificationState(
            todo: CachedTodoModel(),
            todos: const [],
          ),
        );

  NotificationRepository _notificationRepository;

  Future<void> postNotification(NotificationModel notificationModel) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _notificationRepository.postNotification(
          notificationModel: notificationModel);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorText: e.toString()));
      throw e;
    }
  }

  Future<void> addTodo(Map data) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {

      var todo = CachedTodoModel()
        ..title = data['title']
        ..desc = data['desc']
        ..createdAt = data['created_at']
        ..todoType = data['todo_type'];

      await HiveService.instance.addData(todo);

      await getAllTodos();

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorText: e.toString()));
      throw e;
    }
  }
  

  Future<void> getAllTodos() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {

      List<CachedTodoModel> todos = HiveService.instance.getCachedTodos();

      print('ALL TODOS GETED');
      todos.forEach((element) => print(element.title));

      emit(state.copyWith(todos: todos, status: FormzStatus.submissionSuccess));

    } catch (e) {
      emit(state.copyWith(
          errorText: e.toString(), status: FormzStatus.submissionFailure));
    }
  }

  Future<void> clearAllTodos() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await HiveService.instance.deleteAllCachedTodos();
      emit(state.copyWith(todos: [], status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          errorText: e.toString(), status: FormzStatus.submissionFailure));
    }
  }
}
