import 'package:state_notifier/state_notifier.dart';

class TodoSearchState {
  final String searchTerm;
  TodoSearchState({
    required this.searchTerm,
  });
  factory TodoSearchState.initial() {
    return TodoSearchState(searchTerm: '');
  }
  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class TodoSearch extends StateNotifier<TodoSearchState> {
  TodoSearch() : super(TodoSearchState.initial());

  void setSearchTerm(String newSearchTerm) {
    state = state.copyWith(searchTerm: newSearchTerm);
  }
}
