import 'package:search_app/flow/search/data/models/github_repo.dart';

enum FavouritesStatus { initial, loading, success, failure }

class FavouritesState {
  const FavouritesState({
    required this.status,
    this.repos = const [],
  });

  final FavouritesStatus status;
  final List<GithubRepo> repos;

  FavouritesState copyWith({
    FavouritesStatus? status,
    List<GithubRepo>? repos,
  }) =>
      FavouritesState(
        status: status ?? this.status,
        repos: repos ?? this.repos,
      );
}
