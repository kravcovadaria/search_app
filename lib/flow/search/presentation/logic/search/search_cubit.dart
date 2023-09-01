import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:search_app/app/data/models/github_repo.dart';
import 'package:search_app/flow/search/domain/repositories/search_repository.dart';
import 'package:search_app/flow/search/presentation/logic/search/search_state.dart';
export 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.repository)
      : super(const SearchState(status: SearchStatus.initial));

  final SearchRepository repository;

  Future<void> fetch(String searchString) async {
    emit(state.copyWith(
        searchString: searchString, status: SearchStatus.loading));

    try {
      List<GithubRepo> repos =
          await repository.searchRepos(perPage: 15, searchString: searchString);
      emit(state.copyWith(repos: repos));
      markFavourites();
    } catch (e, stack) {
      debugPrint('$e\n$stack');
      emit(state.copyWith(status: SearchStatus.failure, repos: []));
    }
  }

  Future<void> markFavourites() async {
    List<GithubRepo> repos = state.repos.toList();
    Box<GithubRepo> favourites = await Hive.openBox<GithubRepo>('favourites');
    List<GithubRepo> favouritesList = favourites.values.toList();
    for (var repo in repos) {
      repos[repos.indexOf(repo)] = repo.copyWith(
          favourite:
              (favouritesList.firstWhereOrNull((fav) => fav.url == repo.url) !=
                  null));
    }
    emit(state.copyWith(status: SearchStatus.success, repos: repos));
  }

  void clear() => fetch('');

  Future<void> toggleFavs(GithubRepo repo) async {
    final GithubRepo newRepo = await repository.toggleFavs(repo);
    int index = state.repos.indexWhere((element) => element.url == newRepo.url);
    if (index < 0) return;

    List<GithubRepo> newList = List<GithubRepo>.from(state.repos);
    newList[index] = newRepo;
    emit(state.copyWith(repos: newList));
  }
}
