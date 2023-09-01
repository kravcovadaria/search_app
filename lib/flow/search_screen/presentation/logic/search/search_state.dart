enum SearchStatus { initial, loading, success, failure }

class SearchState {
  const SearchState({required this.status});

  final SearchStatus status;

  SearchState copyWith({SearchStatus? status}) {
    return SearchState(status: status ?? this.status);
  }
}
