import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';
import 'package:search_app/flow/search/domain/repositories/search_repository.dart';
import 'package:search_app/flow/search/presentation/logic/search/search_state.dart';
export 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.repository)
      : super(const SearchState(status: SearchStatus.initial));

  final ISearchRepository repository;

  void clear() => fetch('');

  Future<void> fetch(String searchString) async {
    emit(state.copyWith(
      searchString: searchString,
      status: SearchStatus.loading,
    ));

    try {
      List<GithubRepo> repos = await repository.searchRepos(searchString);
      emit(state.copyWith(repos: repos));
      await markFavourites();
      emit(state.copyWith(status: SearchStatus.success));
    } catch (e, stack) {
      log('$e\n$stack');
      emit(state.copyWith(status: SearchStatus.failure, repos: []));
    }
  }

  Future<void> markFavourites() async {
    try {
      List<GithubRepo> repos = state.repos.toList();
      List<GithubRepo> favouritesList = await repository.getFavourites();
      for (var repo in repos) {
        repos[repos.indexOf(repo)] = repo.copyWith(
            favourite: (favouritesList
                    .firstWhereOrNull((fav) => fav.url == repo.url) !=
                null));
      }
      emit(state.copyWith(repos: repos));
    } catch (e, stack) {
      log('$e\n$stack');
    }
  }

  Future<void> toggleFavs(GithubRepo repo) async {
    try {
      final GithubRepo newRepo = await repository.toggleFavs(repo);
      int index =
          state.repos.indexWhere((element) => element.url == newRepo.url);
      if (index < 0) return;

      List<GithubRepo> newList = List<GithubRepo>.from(state.repos);
      newList[index] = newRepo;
      emit(state.copyWith(repos: newList));
    } catch (e, stack) {
      log('$e\n$stack');
    }
  }
}
