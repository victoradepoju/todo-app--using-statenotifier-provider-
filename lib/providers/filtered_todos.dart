// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app/providers/providers.dart';
import 'package:flutter_app/providers/todo_filter.dart';
import 'package:flutter_app/providers/todo_list.dart';
import 'package:flutter_app/providers/todo_search.dart';
import 'package:state_notifier/state_notifier.dart';

import '../models/todo_model.dart';

class FilteredTodoState {
  final List<Todo> filteredTodos;
  FilteredTodoState({
    required this.filteredTodos,
  });

  factory FilteredTodoState.initial() {
    return FilteredTodoState(filteredTodos: []);
  }

  FilteredTodoState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodoState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos extends StateNotifier<FilteredTodoState> with LocatorMixin {
  FilteredTodos() : super(FilteredTodoState.initial());

  // FilteredTodoState get state {
  //   List<Todo> _filteredTodos;

  //   switch (todoFilter.state.filter) {
  //     case Filter.active:
  //       _filteredTodos =
  //           todoList.state.todos.where((Todo todo) => !todo.completed).toList();
  //       break;
  //     case Filter.completed:
  //       _filteredTodos =
  //           todoList.state.todos.where((Todo todo) => todo.completed).toList();
  //       break;
  //     case Filter.all:
  //     default:
  //       _filteredTodos = todoList.state.todos;
  //       break;
  //   }

  //   if (todoSearch.state.searchTerm.isNotEmpty) {
  //     _filteredTodos = _filteredTodos
  //         .where((Todo todo) =>
  //             todo.desc.toLowerCase().contains(todoSearch.state.searchTerm))
  //         .toList();
  //   }
  //   return FilteredTodoState(filteredTodos: _filteredTodos);
  // }

  @override
  void update(Locator watch) {
    final Filter filter = watch<TodoFilterState>().filter;
    final String searchTerm = watch<TodoSearchState>().searchTerm;
    final List<Todo> todos = watch<TodoListState>().todos;

    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }
    state = state.copyWith(filteredTodos: _filteredTodos);
    super.update(watch);
  }
}
