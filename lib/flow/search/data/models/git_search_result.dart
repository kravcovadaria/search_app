import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:search_app/flow/search/data/models/github_repo.dart';

part 'git_search_result.freezed.dart';
part 'git_search_result.g.dart';

@freezed
class GitSearchResult with _$GitSearchResult {
  const factory GitSearchResult({
    @Default(0) @JsonKey(name: 'total_count') int totalCount,
    @Default(false) @JsonKey(name: 'incomplete_results') bool incompleteResults,
    @Default([]) List<GithubRepo> items,
  }) = _GitSearchResult;

  factory GitSearchResult.fromJson(Map<String, dynamic> json) =>
      _$GitSearchResultFromJson(json);
}
