import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:search_app/flow/search/data/models/git_search_result.dart';

part 'search_datasource.g.dart';

@RestApi()
abstract class ISearchDataSource {
  factory ISearchDataSource(Dio client) = _ISearchDataSource;

  @GET("/search/repositories")
  Future<GitSearchResult> searchRepos(
      @Query('q') String searchString, @Query('per_page') int perPage);
}
