import 'package:dio/dio.dart';
import 'package:search_app/app/data/models/github_repo.dart';
import 'package:search_app/flow/search_screen/data/datasources/search_datasource.dart';
import 'package:search_app/management/network/api_manager.dart';

abstract class ISearchRepository {
  Future<List<GithubRepo>> searchRepos({
    required String searchString,
    required int perPage,
  });
}

class SearchRepository implements ISearchRepository {
  @override
  Future<List<GithubRepo>> searchRepos(
      {required String searchString, required int perPage}) async {
    Dio dio = ApiManager().getDio();
    List<GithubRepo> result = await ISearchDataSource(dio).searchRepos(
      searchString,
      perPage,
    );
    return result;
  }
}
