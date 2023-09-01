import 'package:search_app/app/data/models/github_repo.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState {
  const SearchState({
    required this.status,
    this.searchString = '',
    this.repos = const [],
  });

  final SearchStatus status;
  final String searchString;
  final List<GithubRepo> repos;

  SearchState copyWith({
    SearchStatus? status,
    String? searchString,
    List<GithubRepo>? repos,
  }) =>
      SearchState(
        status: status ?? this.status,
        searchString: searchString ?? this.searchString,
        repos: repos ?? this.repos,
      );
}
