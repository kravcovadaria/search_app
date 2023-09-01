import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:search_app/app/data/models/github_repo.dart';

part 'search_datasource.g.dart';

@RestApi()
abstract class ISearchDataSource {
  factory ISearchDataSource(Dio client) = _ISearchDataSource;

  @GET("/search/repositories")
  @FormUrlEncoded()
  Future<List<GithubRepo>> searchRepos(
      @Query('q') String searchString, @Query('per_page') int perPage);
}
