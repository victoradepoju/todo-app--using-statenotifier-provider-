// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app/models/todo_model.dart';
import 'package:state_notifier/state_notifier.dart';

class TodoFilterState {
  final Filter filter;
  TodoFilterState({
    required this.filter,
  });

  factory TodoFilterState.initial() {
    //so we can know the initial state anytime
    return TodoFilterState(
        filter: Filter.all); //landing page has to show ALL the todos
  }

  TodoFilterState copyWith({
    //from equatable..//to create a new state //because this is what we will be editing.
    //also copyWith is better because only the changed value need to be passed and not all.
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

class TodoFilter extends StateNotifier<TodoFilterState> {
  TodoFilter() : super(TodoFilterState.initial());

  void changeFilter(Filter newFilter) {
    state = state.copyWith(filter: newFilter);
  }
}
