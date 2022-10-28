part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  NotificationState({
    this.status = FormzStatus.pure,
    required this.todo,
    required this.todos,
    this.errorText = '',
  });

  CachedTodoModel todo;
  FormzStatus status;
  List<CachedTodoModel> todos;
  String errorText;

  NotificationState copyWith({
    CachedTodoModel? todo,
    List<CachedTodoModel>? todos,
    FormzStatus? status,
    String? errorText,
  }) =>
      NotificationState(
        todo: todo ?? this.todo,
        todos: todos ?? this.todos,
        status: status ?? this.status,
        errorText: errorText ?? this.errorText,
      );

  @override
  List<Object?> get props => [
        todo,
        status,
        todos,
        errorText,
      ];
}
