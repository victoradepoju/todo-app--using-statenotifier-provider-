// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app/providers/todo_list.dart';
import 'package:state_notifier/state_notifier.dart';

import '../models/todo_model.dart';

class ActiveTodoCountState {
  final int activeTodoCount;
  ActiveTodoCountState({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount extends StateNotifier<ActiveTodoCountState>
    with LocatorMixin {
  ActiveTodoCount() : super(ActiveTodoCountState.initial());

  // ActiveTodoCountState get state => ActiveTodoCountState(
  //       activeTodoCount: todoList.state.todos
  //           .where((Todo todo) => !todo.completed)
  //           .toList()
  //           .length,
  //     );               ...from using proxy

  @override
  void update(Locator watch) {
    final List<Todo> todos = watch<TodoListState>().todos;
    state = state.copyWith(
      activeTodoCount:
          todos.where((Todo todo) => !todo.completed).toList().length,
    );
    super.update(watch);
  }
}
