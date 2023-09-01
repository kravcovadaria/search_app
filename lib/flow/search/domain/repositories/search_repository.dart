import 'package:dio/dio.dart';
import 'package:search_app/app/data/datasources/local_datasource.dart';
import 'package:search_app/app/data/models/github_repo.dart';
import 'package:search_app/flow/search/data/datasources/search_datasource.dart';
import 'package:search_app/flow/search/data/models/git_search_result.dart';
import 'package:search_app/management/network/api_manager.dart';

abstract class ISearchRepository {
  Future<List<GithubRepo>> searchRepos({
    required String searchString,
    required int perPage,
  });

  Future<void> toggleFavs(GithubRepo repo);

  Future<List<GithubRepo>> getFavourites();
}

class SearchRepository implements ISearchRepository {
  SearchRepository(this.localDatasource);

  final LocalDatasource localDatasource;

  @override
  Future<List<GithubRepo>> searchRepos({
    required String searchString,
    required int perPage,
  }) async {

    if(searchString.isEmpty) return localDatasource.getHistory();

    Dio dio = ApiManager().getDio();
    GitSearchResult result = await ISearchDataSource(dio).searchRepos(
      searchString,
      perPage,
    );
    localDatasource.updateHistory(result.items);
    return List<GithubRepo>.from(result.items);
  }

  @override
  Future<GithubRepo> toggleFavs(GithubRepo repo) =>
      localDatasource.toggleFavs(repo);

  @override
  Future<List<GithubRepo>> getFavourites() => localDatasource.getFavourites();
}
