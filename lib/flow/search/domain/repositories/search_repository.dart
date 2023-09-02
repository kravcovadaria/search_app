import 'package:search_app/common/app_config.dart';
import 'package:search_app/flow/search/data/datasources/favorites_datasource.dart';
import 'package:search_app/flow/search/data/datasources/history_datasource.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';
import 'package:search_app/flow/search/data/datasources/search_datasource.dart';
import 'package:search_app/flow/search/data/models/git_search_result.dart';
import 'package:search_app/flow/search/domain/repositories/favourites_repository.dart';

abstract class ISearchRepository implements IFavouritesRepository {
  Future<List<GithubRepo>> searchRepos(String searchString);
}

class SearchRepository implements ISearchRepository {
  SearchRepository({
    required this.favouritesDatasource,
    required this.historyDatasource,
    required this.searchDataSource,
  });

  final IFavouritesDatasource favouritesDatasource;
  final IHistoryDatasource historyDatasource;
  final ISearchDataSource searchDataSource;

  @override
  Future<List<GithubRepo>> searchRepos(String searchString) async {
    if (searchString.isEmpty) return historyDatasource.getHistory();

    GitSearchResult result = await searchDataSource.searchRepos(
      searchString,
      AppConfig.searchSize,
    );
    historyDatasource.updateHistory(result.items);
    return List<GithubRepo>.from(result.items);
  }

  @override
  Future<List<GithubRepo>> getFavourites() =>
      favouritesDatasource.getFavourites();

  @override
  Future<GithubRepo> toggleFavs(GithubRepo repo) =>
      favouritesDatasource.toggleFavs(repo);
}
