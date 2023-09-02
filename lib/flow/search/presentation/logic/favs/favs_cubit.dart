import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';
import 'package:search_app/flow/search/domain/repositories/favourites_repository.dart';
import 'package:search_app/flow/search/presentation/logic/favs/favs_state.dart';
export 'favs_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit(this.repository)
      : super(const FavouritesState(status: FavouritesStatus.initial));

  final IFavouritesRepository repository;

  Future<void> fetch() async {
    if(state.status == FavouritesStatus.loading) return;

    emit(state.copyWith(
      status: FavouritesStatus.loading,
    ));

    try {
      List<GithubRepo> repos = await repository.getFavourites();
      emit(state.copyWith(status: FavouritesStatus.success, repos: repos));
    } catch (e, stack) {
      log('$e\n$stack');
      emit(state.copyWith(status: FavouritesStatus.failure, repos: []));
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
